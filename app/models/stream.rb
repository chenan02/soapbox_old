class Stream < ActiveRecord::Base
	has_many :relationships, dependent: :destroy

	def followers
		follower_ids = "SELECT follower_id FROM relationships WHERE followed_id = :stream_id"
	end

end
