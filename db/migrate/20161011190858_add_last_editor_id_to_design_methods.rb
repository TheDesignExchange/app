class AddLastEditorIdToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :last_editor_id, :integer
  end
end
