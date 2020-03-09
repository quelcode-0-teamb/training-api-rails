class UserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :user_private,
             :created_at,
             :updated_at
end
