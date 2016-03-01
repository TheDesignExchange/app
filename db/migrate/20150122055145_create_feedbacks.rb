class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.string :title
      t.string :email
      t.string :feedbacktype
      t.text :body
      t.string :status, :default => "UNREAD"
      t.index :created_at
      
      t.timestamps null: false
    end
  end
end
