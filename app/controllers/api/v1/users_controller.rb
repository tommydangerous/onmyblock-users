class Api::V1::UsersController < ApiController
  def create
    render json: sign_up_service.response, status: sign_up_service.status
  end

  # def destroy
  #   User.find(params[:id]).destroy
  #   head 204
  # end

  # def show
  #   render json: User.find(params[:id]), status: 200
  # end

  # def update
  #   user = User.find params[:id]
  #   if user.update(user_params)
  #     render json: user, status: 200, location: [:api, user]
  #   else
  #     render json: { errors: user.errors }.to_json, status: 422
  #   end
  # end

  private

  def sign_up_service
    if @sign_up_service.nil?
      @sign_up_service = UserCredentialService.new user_params
      @sign_up_service.process
    end
    @sign_up_service
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
