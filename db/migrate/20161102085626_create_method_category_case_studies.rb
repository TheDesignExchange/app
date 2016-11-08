class CreateMethodCategoryCaseStudies < ActiveRecord::Migration
  def change
    create_table :method_category_case_studies do |t|

      t.timestamps
    end
  end
end
