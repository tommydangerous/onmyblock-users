class CredentialResetMailer < BaseMailer
  def create(options)
    capture_options options
    mail from: from, subject: subject, to: to
  end
end
