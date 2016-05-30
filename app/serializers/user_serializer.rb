class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :email, :group_ids
end
