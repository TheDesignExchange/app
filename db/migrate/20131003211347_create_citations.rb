class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.text :text

      t.timestamps
    end
  end
end
