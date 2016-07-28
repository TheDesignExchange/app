class RemovePictureFromCaseStudies < ActiveRecord::Migration
  def change
    remove_column :case_studies, :picture, :integer
  end
end
