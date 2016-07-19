class AddHiddenToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :hidden, :boolean
end
