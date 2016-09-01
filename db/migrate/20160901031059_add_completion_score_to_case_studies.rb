class AddCompletionScoreToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :completion_score, :integer
  end
end
