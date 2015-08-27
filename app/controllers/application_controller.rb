class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |_exception|
    if current_user.try(:role) == "deactivated"
      flash[:error] = "Your account is deactivated! Click on \'Reactivate my account\' to keep using Swapsniper"
      redirect_to user_path(current_user)
    else
      flash[:error] = "You're not allowed to do that!"
      redirect_to root_url
    end
  end
end
