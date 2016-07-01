class AddIsPrivateToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :is_private, :boolean
  end
end
