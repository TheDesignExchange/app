class AddCaseStudyIdToMethodCategoryCaseStudy < ActiveRecord::Migration
  def change
    add_column :method_category_case_studies, :case_study_id, :integer
  end
end
