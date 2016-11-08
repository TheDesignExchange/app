class AddLastEditorToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :last_editor, :string
  end
end
