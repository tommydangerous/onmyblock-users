class CredentialResetWithIdentification
  delegate :save, :valid?, to: :credential_reset

  def initialize(options = {})
    @identification = options[:identification]
  end

  def credential_reset
    @credential_reset ||= create_credential_reset
  end

  def errors
    if valid?
      {}
    else
      { credential: "does not exist" }
    end
  end

  private

  def create_credential_reset
    if credential
      credential.credential_resets.new expires_at: expires_at, token: token
    else
      Credential.new
    end
  end

  def credential
    @credential ||= Credential.find_by identification: @identification
  end

  def expires_at
    Time.zone.now + 3.days
  end

  def token
    SecureRandom.uuid
  end
end
