class ChangeAddForeignKeyToExercise < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :exercises, :users
  end
end
