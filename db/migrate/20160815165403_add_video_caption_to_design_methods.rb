class AddVideoCaptionToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :video_caption, :string
  end
end
