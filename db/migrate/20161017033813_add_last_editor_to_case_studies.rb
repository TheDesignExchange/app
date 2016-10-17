class AddLastEditorToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :last_editor, :string
  end
end
