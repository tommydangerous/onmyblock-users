class CredentialMailer < BaseMailer
  def confirmation(credential, key)
    @url = api_v1_credential_url(
      host: host, id: credential.id, token: key.token, _method: "PUT"
    )
    mail subject: "Confirmation", to: credential.identification
  end
end
