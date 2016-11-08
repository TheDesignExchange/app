class AddVideoTwoCaptionToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :video_two_caption, :string
  end
end
