class Session
  def initialize(token)
    @token = token
  end

  def current_user
    @current_user ||= user_from_key
  end

  def expired?
    key.expired?
  end

  def signed_in?
    !current_user.nil?
  end

  private

  def key
    @key ||= Key.find_by token: @token
  end

  def user_from_key
    key.credential.user
  rescue
    nil
  end
end
