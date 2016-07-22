class AddProdImageToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :prod_image, :text
  end
end
