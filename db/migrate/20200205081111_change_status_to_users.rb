class ChangeStatusToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :status, :boolean, default: false, null: false
  end
end
