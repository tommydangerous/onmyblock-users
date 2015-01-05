class AuthenticationSerializer < ActiveModel::Serializer
  attributes :token, :expires_at

  def expires_at
    key.try :expires_at
  end

  def token
    key.try :token
  end

  private

  def key
    object.key
  end
end
