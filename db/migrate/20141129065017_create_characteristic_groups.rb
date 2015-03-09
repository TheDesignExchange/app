class CreateCharacteristicGroups < ActiveRecord::Migration
  def change
    create_table :characteristic_groups do |t|
      t.belongs_to :method_category
      t.string :name

      t.timestamps
    end
  end
end
