class AddAkaToDesignMethod < ActiveRecord::Migration
  def change
  	add_column :design_methods, :aka, :string
  end
end
