class AddPictureAndPictureUrlToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :picture, :integer
    add_column :design_methods, :picture_url, :string
  end
end
