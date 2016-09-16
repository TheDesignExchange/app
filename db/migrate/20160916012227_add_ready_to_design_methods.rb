class AddReadyToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :ready, :boolean
  end
end
