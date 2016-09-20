class AddSuggestionsToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :suggestions, :string
  end
end
