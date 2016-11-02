class AddMethodCategoryIdToMethodCategoryCaseStudy < ActiveRecord::Migration
  def change
    add_column :method_category_case_studies, :method_category_id, :integer
  end
end
