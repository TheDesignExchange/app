class AddImgAttributeToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :image_attribution, :string
  end
end
