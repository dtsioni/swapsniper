class OriginsController < LocationsController
  def new
    @origin = Origin.new
  end

  def create
    @origin = Origin.find_or_create_by(origin_params)

    if @origin.save
      current_user.origin = @origin
      current_user.save

      redirect_to root_path
    else
      flash.now[:error] = "Your origin was not created."
      redirect_to root_path
    end
  end

  private

  def origin_params
    params.require(:origin).permit(:campus, :building, :floor)
  end
end
