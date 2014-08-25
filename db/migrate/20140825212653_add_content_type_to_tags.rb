class AddContentTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :content_type, :string, :default => "tag"
  end
end
