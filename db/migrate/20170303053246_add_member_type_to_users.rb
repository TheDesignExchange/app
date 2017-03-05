class AddMemberTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :member_type, :string
  end
end
