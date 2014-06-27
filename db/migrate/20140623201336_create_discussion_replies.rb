class CreateDiscussionReplies < ActiveRecord::Migration
  def change
    create_table :discussion_replies do |t|
      t.text :text
      t.integer :user_id
      t.integer :discussion_id
      t.integer :discussion_reply_id

      t.timestamps
    end

    add_index :discussion_replies, :user_id
    add_index :discussion_replies, :discussion_id
    add_index :discussion_replies, :discussion_reply_id
  end
end
