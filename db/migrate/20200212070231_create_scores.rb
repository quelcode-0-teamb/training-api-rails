class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.float :weight
      t.integer :repetitions
      t.integer :interval_time
      t.float :rpe
      t.references :user, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
