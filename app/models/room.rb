class Room < ActiveRecord::Base

  attr_accessible :no, :capacity

  # = Validations =
  validates_presence_of :no, :capacity
  validates_uniqueness_of :no

  # = Relationships =
  has_many :timetable_slots

  # = Scopes =
  scope :by_no, order('no')

  def to_param
    no
  end
end
