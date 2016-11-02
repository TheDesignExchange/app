class AddTagIdToTagCaseStudy < ActiveRecord::Migration
  def change
    add_column :tag_case_studies, :tag_id, :integer
  end
end
