class AddCaseStudyIdToMethodCollection < ActiveRecord::Migration
  def change
  	if column_exists? :method_collections, :case_study_id
      remove_column :method_collections, :case_study_id
    else
      add_column :method_collections, :case_study_id, :integer
    end
  	
  end
end
