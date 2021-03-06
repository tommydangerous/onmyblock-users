class Session
  def initialize(token)
    @token = token
  end

  def key
    @key ||= Key.find_by token: @token
  end

  delegate :expired?, to: :key

  def signed_in?
    !user.nil?
  end

  def user
    @user ||= user_from_key
  end

  private

  def user_from_key
    key.credential.user
  rescue
    nil
  end
end
