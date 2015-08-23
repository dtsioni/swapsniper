class User < ActiveRecord::Base
  include Clearance::User
  belongs_to :origin
  belongs_to :destination
  accepts_nested_attributes_for :origin
  accepts_nested_attributes_for :destination

  validates_presence_of :first_name, :last_name, :gender

  GENDERS = %w[male female]

  def matches
  end
end
