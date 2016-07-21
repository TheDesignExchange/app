class AddHiddenToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :hidden, :boolean, :default => false
  end
end
