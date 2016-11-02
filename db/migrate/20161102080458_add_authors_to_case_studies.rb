class AddAuthorsToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :authors, :string
  end
end
