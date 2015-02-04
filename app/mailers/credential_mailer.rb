class CredentialMailer < BaseMailer
  def confirmation(opts)
    capture_options opts
    mail from: from, subject: "Confirmation", to: to
  end
end
