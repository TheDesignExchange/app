class CreateDiscussions < ActiveRecord::Migration
  def change
    create_table :discussions do |t|
      t.string :title
      t.text :description
      t.integer :user_id, null: false

      t.timestamps
    end

    add_index :discussions, :user_id
    add_index :discussions, :title
  end
end
