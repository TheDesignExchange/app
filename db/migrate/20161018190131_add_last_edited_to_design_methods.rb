class AddLastEditedToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :last_edited, :datetime
  end
end
