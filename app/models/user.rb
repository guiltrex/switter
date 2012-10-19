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
	
	def admin?
		self.admin
	end
  
  private
  def generate_token(column)
		begin
			self[column]=SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end	
end
