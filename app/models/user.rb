class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :origin
  belongs_to :destination
  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :destination

  validates_presence_of :first_name, :last_name, :gender

  GENDERS = %w[male female]

  def matches
    @matches = nil
    #find users that live where i want to live
    @where_i_want_to_live = Origin.find_by(campus: self.destination.campus, building: self.destination.building)
    return if @where_i_want_to_live.nil?
    @residents = User.where(origin_id: @where_i_want_to_live.id)
    #find users that want to live where i live
    @where_i_live = Destination.find_by(campus: self.origin.campus, building: self.origin.building)
    return if @where_i_live.nil?
    @migrators = User.where(destination_id: @where_i_live.id)
    #the intersection of these two arrays are our matches
    @matches = @residents & @migrators
  end
end
