class ChangeVideoTwoAttributionFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :video_two_attribution, :text
  end

  def down
    change_column :design_methods, :video_two_attribution, :string
  end
end
