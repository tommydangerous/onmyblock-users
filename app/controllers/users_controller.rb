class UsersController < UsersApplicationController

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name)
  end
end
