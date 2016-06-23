class AddCaseStudyIdToMethodCollection < ActiveRecord::Migration
  def change
  	add_column :method_collections, :case_study_id, :integer
  end
end
