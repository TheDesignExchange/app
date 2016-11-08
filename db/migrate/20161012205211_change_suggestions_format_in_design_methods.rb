class ChangeSuggestionsFormatInDesignMethods < ActiveRecord::Migration
  def up
    change_column :design_methods, :suggestions, :text
  end

  def down
    change_column :design_methods, :suggestions, :string
  end
end
