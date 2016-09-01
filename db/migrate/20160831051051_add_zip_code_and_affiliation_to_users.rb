class AddZipCodeAndAffiliationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :affiliation, :string
  end
end
