class ExerciseSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :category,
             :user_id,
             :created_at,
             :updated_at
end
