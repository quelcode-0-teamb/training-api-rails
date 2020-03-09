class RoutineSerializer < ActiveModel::Serializer
  attributes :id,
             :user_id,
             :name,
             :created_at,
             :updated_at
end
