class ScoreSerializer < ActiveModel::Serializer
  attributes :id,
             :weight,
             :repetitions,
             :interval_time,
             :rpe,
             :date,
             :exercise_id,
             :user_id,
             :created_at,
             :updated_at
end
