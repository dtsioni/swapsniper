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

  def create
    @user = user_from_params

    @user.origin = Origin.find_or_create_by(campus: @user.origin.campus, building: @user.origin.building)
    @user.destination = Destination.find_or_create_by(campus: @user.destination.campus, building: @user.destination.building)

    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :gender,
      destination_attributes: [:campus, :building], origin_attributes: [:campus, :building])
  end
end
