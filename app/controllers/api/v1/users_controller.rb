class Api::V1::UsersController < Api::V1::UsersApplicationController
  def show
    @user = User.find params[:id]
    render json: @user, root: false, status: :ok
  end
end
