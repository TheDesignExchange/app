class AddVideoAttributionToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :video_attribution, :string
  end
end
