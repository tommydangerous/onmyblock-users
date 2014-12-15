module AuthenticationsHelper
  def authenticate
    !current_user.nil?
  end

  def current_user
    @current_user ||= AuthenticateService
  end
end
