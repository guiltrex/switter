class AddPostPicToMicrposts < ActiveRecord::Migration
  def change
    add_column :microposts, :post_pic, :string
  end
end
