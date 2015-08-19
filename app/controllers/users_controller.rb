class UsersController < Clearance::UsersController
  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :gender)
  end
end
