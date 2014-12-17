class UserMailer < BaseMailer
  def confirmation(user)
    @user = user
    mail to: user.email, subject: "Confirmation"
  end
end
