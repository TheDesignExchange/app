class AddEditorIdToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :editor_id, :int
  end
end
