class AddPictureAndPictureUrlToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :picture, :integer
    add_column :case_studies, :picture_url, :string

    #remove_column :case_studies, :picture, :integer
    #remove_column :case_studies, :picture_url, :integer
  end
end
