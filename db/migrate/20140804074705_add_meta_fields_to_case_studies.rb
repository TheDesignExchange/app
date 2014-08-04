class AddMetaFieldsToCaseStudies < ActiveRecord::Migration
  def change
  	add_column :case_studies, :num_of_designers, :integer, default: 1
    add_column :case_studies, :num_of_users, :integer, default: 1
    add_column :case_studies, :time_period, :integer, default: ""
    add_column :case_studies, :time_unit, :string, default: ""
  end
end
