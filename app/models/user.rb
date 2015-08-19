class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :origin
  belongs_to :destination

  validates_presence_of :first_name, :last_name
end
