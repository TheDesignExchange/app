class AddResourceToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :resource, :string
    add_column :case_studies, :problem, :text
    add_column :case_studies, :process, :text
    add_column :case_studies, :outcome, :text
  end
end
