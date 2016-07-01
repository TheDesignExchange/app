class AddDesignMethodRefToCollections < ActiveRecord::Migration
  def change
    add_reference :collections, :design_method, index: true
  end
end
