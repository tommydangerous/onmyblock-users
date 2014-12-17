class UserMailer < BaseMailer
  def confirmation(user)
    @url = user
    mail to: user.email, subject: "Confirmation"
  end
end
