class RemoveCaseStudyIdFromMethodCollections < ActiveRecord::Migration
  def change
    remove_column :method_collections, :case_study_id, :integer
  end
end
