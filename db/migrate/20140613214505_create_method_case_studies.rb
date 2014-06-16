class CreateMethodCaseStudies < ActiveRecord::Migration
  def change
    create_table :method_case_studies do |t|
      t.integer :case_study_id
      t.integer :design_method_id
      t.timestamps
    end
  end
end
