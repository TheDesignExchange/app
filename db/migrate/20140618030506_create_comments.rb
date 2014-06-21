class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :text
      t.integer :user_id
      t.integer :design_method_id
      t.integer :parent_id
      t.integer :display_order
      t.integer :indent

      t.timestamps
    end
  end
end
