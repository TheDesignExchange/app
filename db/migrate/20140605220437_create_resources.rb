class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name, :default => ""
      t.boolean :permission_to_use, :default => false
      t.string :type, :default => ""
      t.integer :company_id
      t.timestamps
    end
  end
end
