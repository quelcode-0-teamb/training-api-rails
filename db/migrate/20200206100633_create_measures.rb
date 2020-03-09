class CreateMeasures < ActiveRecord::Migration[6.0]
  def change
    create_table :measures do |t|
      t.references :user, foreign_key: true
      t.float :body_weight
      t.float :calorie
      t.float :neck
      t.float :shoulder
      t.float :chest
      t.float :left_biceps
      t.float :right_biceps
      t.float :left_forearm
      t.float :right_forearm
      t.float :upper_abdomen
      t.float :lower_abdomen
      t.float :waist
      t.float :hips
      t.float :left_thigh
      t.float :right_thigh
      t.float :left_calf
      t.float :right_calf
      t.date :date

      t.timestamps
    end
  end
end
