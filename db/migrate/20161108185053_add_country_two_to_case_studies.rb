class AddCountryTwoToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :country_two, :string
  end
end
