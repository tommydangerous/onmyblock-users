unless Rails.env.development? || Rails.env.test?
  ActionMailer::Base.smtp_settings = {
    address:              ENV.fetch("SMTP_ADDRESS", ""),
    authentication:       :login,
    domain:               ENV.fetch("HOST", ""),
    enable_starttls_auto: true,
    password:             ENV.fetch("SMTP_PASSWORD", ""),
    port:                 ENV.fetch("SMTP_PORT", ""),
    user_name:            ENV.fetch("SMTP_USER_NAME", "")
  }
end
