class CredentialResetWithMail < SimplerDelegator
  alias_method :credential_reset, :object

  def save
    super && deliver_email
  end

  private

  def deliver_email
    mailer.save
  end

  def mailer
    Mailer.new(
      deliver_action: "create", name: "credential_reset", payload: payload
    )
  end

  def payload
    {
      from:     "support@onmyblock.com",
      fromname: "OnMyBlock",
      subject:  "Password Reset",
      text:     "reset link",
      to:       credential_reset.credential.identification
    }
  end
end
