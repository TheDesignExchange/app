class AddExpFieldsToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :synonyms, :text
    add_column :design_methods, :benefits, :text
    add_column :design_methods, :limitations, :text
    add_column :design_methods, :skills, :text
    add_column :design_methods, :usage, :text
    add_column :design_methods, :tools, :text
    add_column :design_methods, :history, :text
    add_column :design_methods, :critiques, :text
    add_column :design_methods, :additional_reading, :text
  end
end
