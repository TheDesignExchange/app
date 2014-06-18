class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :name,  :default => ""
      t.string :email,  :default => ""
      t.string :phone, :default => ""
      t.integer :company_id
      t.timestamps
    end
  end
end
