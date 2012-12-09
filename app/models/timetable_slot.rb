class TimetableSlot < ActiveRecord::Base

  attr_accessible :lecture_course, :room, :time_slot, :week

  # = Validations =
  validates_presence_of :lecture_course, :room, :time_slot, :week

  # = Relationships =
  belongs_to :lecture_course
  belongs_to :room
  belongs_to :time_slot
  belongs_to :week

end
