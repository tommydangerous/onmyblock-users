class CredentialMailerPreview < ActionMailer::Preview
  def confirmation
    credential = Credential.new
    key        = credential.create_access_key
    CredentialMailer.confirmation credential, key
  end
end
