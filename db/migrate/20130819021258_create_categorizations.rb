class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.integer :design_method_id
      t.integer :method_category_id

      t.timestamps
    end

    add_index :categorizations, [:design_method_id, :method_category_id], unique: true, name: 'cat_index'
    add_index :categorizations, :design_method_id
    add_index :categorizations, :method_category_id
  end
end
