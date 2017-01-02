class AddAuthorToAdvancedSearch < ActiveRecord::Migration
  def change
    add_column :advanced_searches, :author, :string
  end
end
