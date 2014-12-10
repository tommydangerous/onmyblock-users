class UserService
  def create_user(options = {})
    user = User.new options
    if user.save
      response = user
      status   = 201
    else
      response = { errors: user.errors }.to_json
      status   = 422
    end
    response_status response, status
  end

  private

  def response_status(response, status)
    { response: response, status:   status }
  end
end
