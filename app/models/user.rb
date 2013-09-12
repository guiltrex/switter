class User < ActiveRecord::Base
  attr_accessible :username, :email, :password, :password_confirmation, 
									:pro_image
  before_save { |user| user.email = email.downcase}
  before_save { generate_token(:remember_token) }
  has_secure_password
  validates :username, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}
  validates :password_confirmation, presence: true  
  mount_uploader :pro_image, ImageUploader
	
	has_many :microposts, :dependent => :destroy
	has_many :friendships, :dependent => :destroy
	has_many :friends, through: :friendships, source: :friend
	
	#Example of :source : has_many :followed_users, through: :relationships, source: :followed
	#Rails allows us to override the default, in this case using the :source parameter 
	#which explicitly tells Rails that the source of the followed_users array is the set of followed ids.
	#So, the source above could be omitted.
	
	def admin?
		self.admin
	end
  
  def friend?(other_user)
		#My version: self.friends.exist?(user.id)
		#ROR tutorial modified version and below:
		self.friendships.find_by_friend_id(other_user.id)
  end
  
  def friend!(other_user)
		self.friendships.create!(friend_id: other_user.id)
  end
  
  def no_more_friend!(other_user)
		self.friendships.find_by_friend_id(other_user.id).destroy if self.friendships.find_by_friend_id(other_user.id)
  end
  

  private
  def generate_token(column)
		begin
			self[column]=SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end	
end
