class CreateMethodLikes < ActiveRecord::Migration
  def change
    create_table :method_likes do |t|
      t.integer :user_id
      t.integer :design_method_id

      t.timestamps
    end
    add_index :method_likes, [:user_id, :design_method_id], unique: true
  end
end
