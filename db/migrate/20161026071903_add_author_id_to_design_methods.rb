class AddAuthorIdToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :author_id, :int
  end
end
