class CreateDesignMethods < ActiveRecord::Migration
  def change
    create_table :design_methods do |t|
      t.string :name, null: false
      t.text :overview, null: false
      t.text :process, null: false
      t.text :principle, null: false

      t.integer :owner_id, null: false
      t.integer :parent_id

      t.timestamps
    end
  end
end
