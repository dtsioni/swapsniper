class UsersController < Clearance::UsersController
  def matches
  end

  def new
    @user = User.new
    @origin = Origin.new
    @destination = Destination.new

    @user.origin = @origin
    @user.destination = @destination

    render template: "users/new"
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :gender,
      destination_attributes: [:campus, :building], origin_attributes: [:campus, :building])
  end
end
