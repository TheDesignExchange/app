class AddMetaFieldsToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :num_of_designers, :integer, default: 1
    add_column :design_methods, :num_of_users, :integer, default: 1
    add_column :design_methods, :time_period, :integer, default: ""
    add_column :design_methods, :time_unit, :string, default: ""
    add_column :design_methods, :main_image, :string
    add_column :design_methods, :likes, :integer,  default: 0
  end
end
