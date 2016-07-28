class AddPictureAndPictureUrlToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :picture, :integer
    add_column :case_studies, :picture_url, :string
  end
end
