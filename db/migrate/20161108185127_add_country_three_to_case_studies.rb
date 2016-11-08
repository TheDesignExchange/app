class AddCountryThreeToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :country_three, :string
  end
end
