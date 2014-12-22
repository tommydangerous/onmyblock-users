class Authentication
  include ActiveModel::Model

  attr_accessor :identification, :password

  attr_reader :key

  validate :authentication

  def save
    if valid?
      create_key ? true : false
    else
      false
    end
  end

  private

  def authentication
    unless credential && credential.authenticate(password)
      errors.add :authentication_failed, "invalid identification or password"
    end
  end

  def create_key
    @key = credential.keys.new.tap(&:configure_defaults).tap(&:save)
  end

  def credential
    @credential ||= Credential.find_by identification: identification
  end
end
