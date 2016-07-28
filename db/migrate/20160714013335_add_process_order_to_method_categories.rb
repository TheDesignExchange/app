class AddProcessOrderToMethodCategories < ActiveRecord::Migration
  def change
    add_column :method_categories, :process_order, :integer
  end
end
