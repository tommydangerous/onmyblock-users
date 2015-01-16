class UserKeySerializer < ActiveModel::Serializer
  def serializable_hash
    key_serializable_hash.merge user_serializable_hash
  end

  private

  def key_serializable_hash
    KeySerializer.new(object.key).serializable_hash
  end

  def user_serializable_hash
    UserSerializer.new(object.user).serializable_hash
  end
end
