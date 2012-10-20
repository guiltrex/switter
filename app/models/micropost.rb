class Micropost < ActiveRecord::Base
  attr_accessible :content, :post_pic
  validates :user_id, presence: true
	validates :content, presence: true, length: { maximum: 400 }  
	
  mount_uploader :post_pic, ImageUploader
  
  belongs_to :user  
  
	default_scope order: 'microposts.created_at DESC'  
end
