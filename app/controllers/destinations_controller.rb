class DestinationsController < LocationsController
  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.find_or_create_by(destination_params)

    if @destination.save
      current_user.destination = @destination
      current_user.save

      redirect_to root_path
    else
      flash.now[:error] = "Your destination was not created."
      redirect_to root_path
    end
  end

  private

  def destination_params
    params.require(:destination).permit(:campus, :building)
  end
end
