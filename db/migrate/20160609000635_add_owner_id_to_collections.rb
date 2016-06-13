class AddOwnerIdToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :owner_id, :integer
  end
end
