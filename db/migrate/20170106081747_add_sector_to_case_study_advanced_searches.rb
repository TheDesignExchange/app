class AddSectorToCaseStudyAdvancedSearches < ActiveRecord::Migration
  def change
    add_column :case_study_advanced_searches, :sector, :string
  end
end
