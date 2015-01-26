class CreateMethodVariations < ActiveRecord::Migration
  def change
    create_table :method_variations do |t|
      t.integer :parent_id
      t.integer :variant_id
      t.timestamps
    end
  end
end
