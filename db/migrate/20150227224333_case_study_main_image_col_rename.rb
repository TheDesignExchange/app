class CaseStudyMainImageColRename < ActiveRecord::Migration
  def change
    rename_column :case_studies, :main_image, :main_image
    rename_column :case_studies, :description, :overview
    rename_column :case_studies, :title, :name
    rename_column :case_studies, :timePeriod, :time_period
    rename_column :case_studies, :customerIsUser, :customer_is_user
    rename_column :case_studies, :remoteProject, :remote_project
  end
end
