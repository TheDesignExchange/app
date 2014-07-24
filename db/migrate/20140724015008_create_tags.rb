class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.integer :design_method_id
      t.integer :case_study_id
      t.integer :discussion_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end
end
