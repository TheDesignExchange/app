class CreateCharacteristics < ActiveRecord::Migration
  def change
    create_table :characteristics do |t|
      t.belongs_to :characteristic_group
      t.string :name
      t.text :description
      
      t.timestamps
    end
  end
end
