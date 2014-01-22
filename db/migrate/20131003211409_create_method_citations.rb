class CreateMethodCitations < ActiveRecord::Migration
  def change
    create_table :method_citations do |t|
      t.integer :design_method_id
      t.integer :citation_id

      t.timestamps
    end

    add_index :method_citations, [:design_method_id, :citation_id], unique: true
    add_index :method_citations, :design_method_id
    add_index :method_citations, :citation_id
  end
end
