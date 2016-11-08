class ChangeImageAttributionCaptionFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :image_attribution, :text
  end

  def down
    change_column :design_methods, :image_attribution, :string
  end
end
