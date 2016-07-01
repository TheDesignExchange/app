class AddCollectionRefToDesignMethods < ActiveRecord::Migration
  def change
    add_reference :design_methods, :collection, index: true
  end
end
