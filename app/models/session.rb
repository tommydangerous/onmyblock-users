class Session
  def initialize(token)
    @token = token
  end

  def current_user
    @current_user ||= user_from_token
  end

  def signed_in?
    !current_user.nil?
  end

  private

  def user_from_token
    Key.find_by(token: @token).credential.user
  rescue
    nil
  end
end
