class CreateMethodCharacteristics < ActiveRecord::Migration
  def change
    create_table :method_characteristics do |t|
      t.integer :design_method_id
      t.integer :characteristic_id

      t.timestamps
    end

    add_index :method_characteristics, [:design_method_id, :characteristic_id], unique: true, name: 'char_index'
    add_index :method_characteristics, :design_method_id
    add_index :method_characteristics, :characteristic_id
  end
end
