class AddKeywordsToAdvancedSearch < ActiveRecord::Migration
  def change
    add_column :advanced_searches, :keywords, :text
  end
end
