class RemovePrincipleFromDesignMethod < ActiveRecord::Migration
  def change
  	remove_column :design_methods, :principle, :text
  end
end
