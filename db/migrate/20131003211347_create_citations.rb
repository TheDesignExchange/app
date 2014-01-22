class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.string :text

      t.timestamps
    end
  end
end
