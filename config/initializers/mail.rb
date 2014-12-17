unless Rails.env.development? || Rails.env.test?
  ActionMailer::Base.smtp_settings = {
    address:              ENV["SMTP_ADDRESS"],
    authentication:       :login,
    domain:               ENV["HOST"],
    enable_starttls_auto: true,
    password:             ENV["SMTP_PASSWORD"],
    port:                 ENV["SMTP_PORT"],
    user_name:            ENV["SMTP_USER_NAME"]
  }
end
