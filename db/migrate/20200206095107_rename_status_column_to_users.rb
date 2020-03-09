class RenameStatusColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :status, :user_private
  end
end
