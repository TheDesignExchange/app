class AddSummaryToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :summary, :text
  end
end
