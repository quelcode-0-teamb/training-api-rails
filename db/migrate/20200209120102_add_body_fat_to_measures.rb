class AddBodyFatToMeasures < ActiveRecord::Migration[6.0]
  def change
    add_column :measures, :body_fat, :float
  end
end
