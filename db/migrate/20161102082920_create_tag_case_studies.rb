class CreateTagCaseStudies < ActiveRecord::Migration
  def change
    create_table :tag_case_studies do |t|

      t.timestamps
    end
  end
end
