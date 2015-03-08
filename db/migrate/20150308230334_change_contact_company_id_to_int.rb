class ChangeContactCompanyIdToInt < ActiveRecord::Migration
  def up
  	change_column :contacts, :company_id, 'integer USING CAST(company_id AS integer)'
  end

  def down
  	change_column :contacts, :company_id, :text
  end
end
