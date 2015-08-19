class Destination < Location
  validates_presence_of :building, if: :campus
end
