class CreateRelatedMethods < ActiveRecord::Migration
  def self.up
    create_table :rms, id: false do |t|
      t.integer :design_method_id
      t.integer :rm_design_method_id
    end
    add_index(:rms, [:design_method_id, :rm_design_method_id], :unique => true)
    add_index(:rms, [:rm_design_method_id, :design_method_id], :unique => true)
  end

  def self.down
    remove_index(:rms, [:rm_design_method_id, :design_method_id])
    remove_index(:rms, [:design_method_id, :rm_design_method_id])
    drop_table :rms
  end
end