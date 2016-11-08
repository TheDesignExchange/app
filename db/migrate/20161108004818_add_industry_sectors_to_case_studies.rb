class AddIndustrySectorsToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :industry_sectors, :string, array: true, default: []
  end
end
