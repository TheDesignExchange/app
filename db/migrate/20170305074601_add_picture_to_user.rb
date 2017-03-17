class AddPictureToUser < ActiveRecord::Migration
  def change
    add_column :users, :picture, :integer
  end
end
