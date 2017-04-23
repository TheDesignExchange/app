class CreateSpellchecks < ActiveRecord::Migration
  def change
    create_table :spellchecks do |t|

      t.timestamps
    end
  end
end
