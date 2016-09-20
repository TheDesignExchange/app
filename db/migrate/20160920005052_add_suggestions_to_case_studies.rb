class AddSuggestionsToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :suggestions, :string
  end
end
