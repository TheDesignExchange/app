class AddEditorIdToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :editor_id, :int
  end
end
