class AddDraftToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :draft, :boolean, :default => false
  end
end
