class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :origin
  belongs_to :destination
  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :destination

  EMAIL_REGEX = /\A.+@(scarletmail.)?rutgers\.edu\z/i

  validates_presence_of :first_name, :last_name, :gender, :role
  validates :email, presence: true, uniqueness: true, format:{ with: EMAIL_REGEX }
  GENDERS = %w[male female]


  def matches
    @matches = nil
    return if self.deactivated?
    #find users that live where i want to live
    #we have to pick all origins with this specific building and campus
    #this is because there are "duplicate" entries, because floor and room type makes the "same" locations "different"
    if self.destination.campus == "anywhere"
      @where_i_want_to_live = Origin.all
    elsif self.destination.building == "anywhere"
      @where_i_want_to_live = Origin.where(campus: self.destination.campus)
    else
      @where_i_want_to_live = Origin.where(campus: self.destination.campus, building: self.destination.building)
    end
    return if @where_i_want_to_live.nil?
    @residents = []
    @where_i_want_to_live.each do |loc|
      @residents = @residents + User.where(origin_id: loc.id)
    end
    #find users that want to live where i live
    @where_i_live = Destination.where(campus: self.origin.campus, building: self.origin.building)
    #also include any users that want to live on my campus, but "anywhere", which is stored as an explicit row
    @where_i_live = @where_i_live + Destination.where(campus: self.origin.campus, building: "anywhere")
    #also include any users that want to live anywhere
    @where_i_live = @where_i_live + Destination.where(campus: "anywhere")
    return if @where_i_live.nil?
    @migrators = []
    @where_i_live.each do |loc|
      @migrators = @migrators + User.where(destination_id: loc.id)
    end
    #the intersection of these two arrays are our matches
    @matches = @residents & @migrators
    #only pick users of the same gender
    @matches = @matches.select do |match|
      match.gender == self.gender
    end
    @matches = @matches.select do |match|
      match.role != "deactivated"
    end
    #make sure you don't match with yourself
    @matches = @matches.select do |match|
      match.email != self.email
    end

  end

  def full_name
    self.first_name + " " + self.last_name
  end

  def full_name_last_initial
    self.first_name + " " + self.last_name.chars.first + "."
  end

  def origin_building_campus
    self.origin.building.titleize + ", " + self.origin.campus.titleize
  end

  def destination_building_campus
    if self.destination.campus == "anywhere"
      @location = "Anywhere"
    elsif self.destination.building == "anywhere"
      @location = self.destination.campus.titleize
    else
      @location = self.destination.building.titleize + ", " + self.destination.campus.titleize
    end
  end

  def origin_summary
    "Floor " + self.origin.floor.to_s + ", " + self.origin.building.titleize + ", " + self.origin.campus.titleize
  end

  def destination_summary
    destination_building_campus
  end

  def description
    "Lives in floor " + self.origin.floor.to_s + " of " + self.origin_building_campus + " and wants to move to " + self.destination_building_campus
  end

  def deactivated?
    self.role == "deactivated"
  end
end
