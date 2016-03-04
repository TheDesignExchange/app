class RenameDesignMethodTools < ActiveRecord::Migration
  def change
    rename_column :design_methods, :tools, :online_resources
  end
end
