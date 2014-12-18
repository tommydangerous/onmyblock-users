class Api::V1::BaseController < ApiController
  private

  def authenticate
    deny_access unless current_session.signed_in? && !current_session.expired?
  end

  def authorization
    request.headers["Authorization"]
  end

  def current_session
    @current_session ||= Session.new authorization
  end

  def deny_access
    render_envelope(
      errors:   deny_access_errors,
      resource: nil,
      status:   401
    )
  end

  def deny_access_errors
    if !current_session.signed_in?
      { access_denied: "you must login" }
    else
      { session_expired: "your session has expired" }
    end
  end
end
