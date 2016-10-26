class AddAuthorIdToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :author_id, :int
  end
end
