class AddBackgroundToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :background, :text
  end
end
