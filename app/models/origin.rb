class Origin < Location
  validates_presence_of :campus, :building
end
