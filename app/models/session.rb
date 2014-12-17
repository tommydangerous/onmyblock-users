class Session
  def initialize(token)
    @token = token
  end

  def current_key
    @current_key ||= Key.find_by token: @token
  end

  def current_user
    @current_user ||= user_from_key
  end

  def expired?
    current_key.expired?
  end

  def signed_in?
    !current_user.nil?
  end

  private

  def user_from_key
    current_key.credential.user
  rescue
    nil
  end
end
