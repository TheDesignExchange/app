class AddHiddenMethodToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :hidden_method, :boolean, :default => false
  end
end
