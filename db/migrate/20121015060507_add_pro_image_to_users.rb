class AddProImageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :pro_image, :string
  end
end
