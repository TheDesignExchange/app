class AddReferencesToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :references, :text
  end
end
