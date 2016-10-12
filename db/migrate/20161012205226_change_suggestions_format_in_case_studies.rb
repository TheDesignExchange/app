class ChangeSuggestionsFormatInCaseStudies < ActiveRecord::Migration
  def up
    change_column :case_studies, :suggestions, :text
  end

  def down
    change_column :case_studies, :suggestions, :string
  end
end
