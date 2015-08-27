class UsersController < Clearance::UsersController
  before_action :require_login, except: [:new, :create]
  load_and_authorize_resource
  skip_load_resource :only => :create


  def matches
    @matches = current_user.matches
  end

  def new
    @user = User.new
    @origin = Origin.new
    @destination = Destination.new

    @user.origin = @origin
    @user.destination = @destination

    render template: "users/new"
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
      flash[:success] = "User was successfully updated!"
    else
      flash.now[:error] = "User was not successfully updated."
      render :edit
    end
  end

  def create
    @user = user_from_params

    @user.origin = Origin.find_or_create_by(campus: @user.origin.campus, building: @user.origin.building, floor: @user.origin.floor, style: @user.origin.style)
    @user.destination = Destination.find_or_create_by(campus: @user.destination.campus, building: @user.destination.building)

    @user.role = "student"
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      render template: "users/new"
    end
  end

  def deactivate
    @user = User.find(params[:id])
    if @user.update_attribute(:role, "deactivated")
    else
      flash[:error] = "Your account could not be deactivated"
      redirect_to user_path(@user)
    end
  end

  def activate
    @user = User.find(params[:id])
    if @user.update_attribute(:role, "student")
      redirect_to edit_user_path(@user)
      flash[:success] = "Your account was reactivated! Please update your information"
    else
      flash[:error] = "Your account could not be reactivated"
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :gender, :note,
      destination_attributes: [:campus, :building], origin_attributes: [:campus, :building, :floor, :style])
  end
end
