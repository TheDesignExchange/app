class AddOwnerIdToCaseStudies < ActiveRecord::Migration
  def change
    add_column :case_studies, :owner_id, :integer
  end
end
