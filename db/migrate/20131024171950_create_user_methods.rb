class CreateUserMethods < ActiveRecord::Migration
  def change
    create_table :user_methods do |t|
      t.integer :user_id, null: false
      t.integer :design_method_id, null: false
      t.integer :type_id, null: false

      t.timestamps
    end

    add_index :user_methods, [:user_id, :design_method_id], unique: true
    add_index :user_methods, :user_id
    add_index :user_methods, :design_method_id
  end
end
