class AddCountryToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :country, :string
  end
end
