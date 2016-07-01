class AddOverviewToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :overview, :text
  end
end
