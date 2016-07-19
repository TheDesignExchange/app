class RemoveHiddenFromDesignMethods < ActiveRecord::Migration
  def change
    remove_column :design_methods, :hidden, :boolean
  end
end
