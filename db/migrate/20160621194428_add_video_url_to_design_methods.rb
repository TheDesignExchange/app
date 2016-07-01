class AddVideoUrlToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :videoURL, :string
  end
end
