class CreateMethodCategories < ActiveRecord::Migration
  def change
    create_table :method_categories do |t|
      t.string :name
      t.integer :parent_id
      t.string :lineage
      t.integer :depth

      t.timestamps
    end
  end
end
