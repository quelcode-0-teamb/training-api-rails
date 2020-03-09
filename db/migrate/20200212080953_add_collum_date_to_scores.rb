class AddCollumDateToScores < ActiveRecord::Migration[6.0]
  def change
    add_column :scores, :date, :date
  end
end
