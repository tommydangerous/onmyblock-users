class CredentialUpdateFromReset
  def initialize(options = {})
    @password = options[:password]
    @token    = options[:token]
  end

  def credential
    if @credential.nil? && credential_reset
      @credential          = credential_reset.credential
      @credential.password = password
    end
    @credential
  end

  def errors
    if credential.nil?
      { invalid_token: "token is invalid" }
    elsif !credential.valid?
      credential.errors
    elsif credential_reset.expired?
      { expired: "token has expired" }
    end
  end

  def save
    if valid?
      credential_reset.update expires_at: Time.zone.now if credential.save
    else
      false
    end
  end

  def valid?
    credential && credential.valid? && !credential_reset.expired?
  end

  private

  def credential_reset
    @credential_reset ||= CredentialReset.find_by token: @token
  end

  def password
    @password || "-"
  end
end
