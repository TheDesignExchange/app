class CreateMcRelations < ActiveRecord::Migration
  def change
    create_table :mc_relations do |t|
      t.integer :parent_id
      t.integer :child_id
      t.integer :distance
      t.string  :description, :default => "subclass"

      t.timestamps
    end

      add_index :mc_relations, [:parent_id, :child_id], unique: true, name: 'mcrelations_index'
      add_index :mc_relations, :parent_id
      add_index :mc_relations, :child_id
  end
end
