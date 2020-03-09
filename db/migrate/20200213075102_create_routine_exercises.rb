class CreateRoutineExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :routine_exercises do |t|
      t.references :routine, foreign_key: true
      t.references :exercise, foreign_key: true

      t.timestamps
    end
  end
end
