class AddVideoUrlTwoToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :videoURL_two, :string
  end
end
