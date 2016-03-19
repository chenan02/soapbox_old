class PasswordResetsController < ApplicationController
	before_action :get_user, only: [:edit, :update]
	before_action :valid_user, only: [:edit, :update]
	before_action :check_expiration, only: [:edit, :update]

	def new
	end

	def create
		@user = User.find_by(phone_number: params[:password_reset][:phone_number])
		if @user
			@user.create_reset_digest
			@user.send_password_reset_text
			flash[:info] = "A password reset text has been sent to your phone."
			redirect_to root_url
		else
			flash.now[:danger] = "Phone number not found."
			render 'new'
		end
	end

	def edit
	end

	def update
		if params[:user][:password].empty?
			@user.errors.add(:password, "can't be empty.")
			render 'edit'
		elsif @user.update_attributes(user_params)
			# may need to fix this
			log_in @user
			flash[:success] = "Password has been reset."
			redirect_to @user
		else
			render 'edit'
		end
	end

	private

		def user_params
			params.require(:user).permit(:password, :password_confirmation)
		end

		def get_user
			@user = User.find_by(phone_number: params[:phone_number])
		end

		def valid_user
			unless (@user && @user.activated? && @user.authenticated?(:reset, params[:id]))
				redirect_to root_url
			end
		end

		def check_expiration
			if @user.password_reset_expired?
				flash[:danger] = "Password reset has expired."
				redirect_to new_password_reset_url
			end
		end
end
