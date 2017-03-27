class AddProcessToAdvancedSearch < ActiveRecord::Migration
  def change
    add_column :advanced_searches, :process, :text
  end
end
