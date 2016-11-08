class AddCaseStudyIdToTagCaseStudy < ActiveRecord::Migration
  def change
    add_column :tag_case_studies, :case_study_id, :integer
  end
end
