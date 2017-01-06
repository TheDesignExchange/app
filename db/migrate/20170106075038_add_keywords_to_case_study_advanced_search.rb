class AddKeywordsToCaseStudyAdvancedSearch < ActiveRecord::Migration
  def change
    add_column :case_study_advanced_searches, :keywords, :string
  end
end
