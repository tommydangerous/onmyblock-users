class UserMailerPreview < ActionMailer::Preview
  def confirmation
    user = User.first
    UserMailer.confirmation user
  end
end
