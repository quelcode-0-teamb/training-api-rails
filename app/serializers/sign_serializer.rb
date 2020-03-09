class SignSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :email,
             :token,
             :user_private,
             :created_at,
             :updated_at
end
