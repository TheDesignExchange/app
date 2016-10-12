class ChangeVideoTwoCaptionFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :video_two_caption, :text
  end

  def down
    change_column :design_methods, :video_two_caption, :string
  end
end
