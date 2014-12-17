class UserMailer < BaseMailer
  def confirmation(user)
    @first_name = user.first_name
    mail to: user.email, subject: "Confirmation"
  end
end
