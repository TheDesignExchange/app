class CreateMethodCollections < ActiveRecord::Migration
  def change
    create_table :method_collections do |t|
      t.integer :design_method_id
      t.integer :collection_id

      t.timestamps
    end
  end
end
