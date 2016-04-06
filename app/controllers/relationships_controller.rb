class RelationshipsController < ApplicationController
  before_action :logged_in_user
  
  def create
    stream = Stream.find(params[:followed_id])
    current_user.follow(stream)
    # if html, redirect to @user (if js disabled). if ajax, ??
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
  def destroy
    stream = Relationship.find(params[:id]).followed
    current_user.unfollow(stream)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
end
