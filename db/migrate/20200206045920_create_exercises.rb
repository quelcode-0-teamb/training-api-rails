class CreateExercises < ActiveRecord::Migration[6.0]
  def change
    create_table :exercises do |t|
      t.string :name
      t.integer :category
      t.references :user

      t.timestamps
    end
  end
end
