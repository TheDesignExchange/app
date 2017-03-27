class CreateCaseStudyAdvancedSearches < ActiveRecord::Migration
  def change
    create_table :case_study_advanced_searches do |t|

      t.timestamps
    end
  end
end
