class AddLastEditorIdToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :last_editor_id, :integer
  end
end
