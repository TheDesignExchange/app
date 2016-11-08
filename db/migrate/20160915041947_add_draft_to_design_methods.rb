class AddDraftToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :draft, :boolean, :default => false
  end
end
