class Api::V1::UsersController < Api::V1::BaseController
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

  def new_create_service
    UserCredentialService.new record_params
  end

  def record_params
    params.require(:user).permit(:email, :first_name, :last_name, :password)
  end
end
