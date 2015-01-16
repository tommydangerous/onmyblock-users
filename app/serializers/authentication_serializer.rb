class AuthenticationSerializer < ActiveModel::Serializer
  attributes :token, :expires_at, :id, :email, :first_name, :last_name

  def email
    user.try :email
  end

  def expires_at
    key.try :expires_at
  end

  def first_name
    user.try :first_name
  end

  def id
    user.id.to_s if user
  end

  def last_name
    user.try :last_name
  end

  def token
    key.try :token
  end

  private

  def key
    object.key
  end

  def user
    @user ||= key.credential.user if key
  end
end
