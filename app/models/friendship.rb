class Friendship < ActiveRecord::Base
  attr_accessible :friend_id
  belongs_to :user 
  belongs_to :friend, class_name: "User"
  
  validates :user_id, :friend_id, :presence => true
	after_create :be_friendly_to_friend
	after_destroy :no_more_nice
	

	def be_friendly_to_friend
		friend.friendships.create(friend_id: self.user.id) unless friend.friends.include?(user)
	end
	
  def no_more_nice
		if friend.friendships.find_by_friend_id(self.user.id)
			friend.friendships.find_by_friend_id(self.user.id).destroy 
		end
	end
  
end
