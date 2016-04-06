class Stream < ActiveRecord::Base
	has_many :relationships, dependent: :destroy

	def followers
		

end
