class AddPictureAndPictureUrlToCaseStudies < ActiveRecord::Migration
  def change
    unless column_exists? :case_studies, :picture
      add_column :case_studies, :picture, :integer
    end
    unless column_exists? :case_studies, :picture_url
      add_column :case_studies, :picture_url, :string
    end
  end
end
