class OtherUserSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :user_private
end
