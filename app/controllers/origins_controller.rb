class OriginsController < LocationsController
  def new
    @origin = Origin.new
  end

  def create
    @origin = Origin.find_or_create_by(origin_params)
    @origin.save
  end

  private

  def origin_params
    params.require(:origin).permit(:campus, :building, :floor, :style)
  end
end
