class CreateCaseStudies < ActiveRecord::Migration
  def change
    create_table :case_studies do |t|

      t.timestamps
    end
  end
end
