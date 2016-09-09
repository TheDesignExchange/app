class AddVideoTwoAttributionToDesignMethods < ActiveRecord::Migration
  def change
    add_column :design_methods, :video_two_attribution, :string
  end
end
