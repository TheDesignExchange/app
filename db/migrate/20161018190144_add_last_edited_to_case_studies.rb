class AddLastEditedToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :last_edited, :datetime
  end
end
