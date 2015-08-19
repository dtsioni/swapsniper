class Destination < Location
  validates_presence_of :campus, if: :building
end
