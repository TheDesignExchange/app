class AddIndustrySectorToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :industry_sector, :string
  end
end
