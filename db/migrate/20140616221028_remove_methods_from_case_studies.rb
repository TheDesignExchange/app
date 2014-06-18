class RemoveMethodsFromCaseStudies < ActiveRecord::Migration
  def change
    remove_column :case_studies, :methods, :string
  end
end
