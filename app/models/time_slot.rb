class TimeSlot < ActiveRecord::Base

  attr_accessible :day, :start_hour

  # = Validations =
  validates_presence_of :day, :start_hour

  # = Relationships =
  belongs_to :day
  has_many :timetable_slots
end
