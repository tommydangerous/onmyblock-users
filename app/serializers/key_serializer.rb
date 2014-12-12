class KeySerializer < ActiveModel::Serializer
  attributes :expires_at, :token
end
