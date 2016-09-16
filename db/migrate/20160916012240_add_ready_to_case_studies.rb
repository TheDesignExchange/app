class AddReadyToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :ready, :boolean
  end
end
