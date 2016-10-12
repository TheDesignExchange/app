class ChangeVideoCaptionFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :video_caption, :text
  end

  def down
    change_column :design_methods, :video_caption, :string
  end
end
