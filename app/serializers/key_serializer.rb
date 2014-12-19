class KeySerializer < ActiveModel::Serializer
  attributes :token, :expires_at
end
