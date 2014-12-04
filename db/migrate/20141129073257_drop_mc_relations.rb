class DropMcRelations < ActiveRecord::Migration
  def change
  	drop_table :mc_relations do |t|
  	end
  end
end
