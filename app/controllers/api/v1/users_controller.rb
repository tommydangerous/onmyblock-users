class Api::V1::UsersController < Api::V1::UsersApplicationController
  def create
    service = CreateService.new(User, user_params, UserSerializer).tap(&:process)
    render json: service.response, status: service.status
  end

  def destroy
    User.find(params[:id]).destroy
    head 204
  end

  def show
    render json: User.find(params[:id]), status: 200
  end

  def update
    user = User.find params[:id]
    if user.update(user_params)
      render json: user, status: 200, location: [:api, user]
    else
      render json: { errors: user.errors }.to_json, status: 422
    end
  end

  private

  def service
    @service ||= UserService.new
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
