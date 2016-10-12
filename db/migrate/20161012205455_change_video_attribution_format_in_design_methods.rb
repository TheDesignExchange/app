class ChangeVideoAttributionFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :video_attribution, :text
  end

  def down
    change_column :design_methods, :video_attribution, :string
  end
end
