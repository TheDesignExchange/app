class CreateMethodVariations < ActiveRecord::Migration
  def change
    create_table :method_variations do |t|
      t.integer :design_method_id, null: false
      t.integer :variation_id, null: false

      t.timestamps
    end

  end
end
