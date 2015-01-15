class AddDefaultValueToStatus < ActiveRecord::Migration
  def change
    change_column :feedbacks, :status, :string, :default => "UNREAD"
  end
end
