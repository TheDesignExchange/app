class DropCategorizations < ActiveRecord::Migration
  def change
  	drop_table :categorizations do |t|
  	end
  end
end
