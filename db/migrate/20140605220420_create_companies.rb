class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, :default => ""
      t.string :domain, :default => ""
      t.string :email, :default => ""
      t.timestamps
    end
  end
end
