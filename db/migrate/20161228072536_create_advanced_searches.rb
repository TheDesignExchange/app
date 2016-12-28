class CreateAdvancedSearches < ActiveRecord::Migration
  def change
    create_table :advanced_searches do |t|

      t.timestamps
    end
  end
end
