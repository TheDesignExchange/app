class CreateDesignMethods < ActiveRecord::Migration
  def change
    create_table :design_methods do |t|
      t.string :name, null: false
      t.text :overview, null: false
      t.text :process, null: false
      t.string :aka

      t.integer :owner_id, null: false

      t.timestamps
    end
  end
end
