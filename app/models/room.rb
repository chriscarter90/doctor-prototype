class Room < ActiveRecord::Base

  attr_accessible :no, :capacity, :year

  # = Validations =
  validates_presence_of :no, :capacity, :year

  # = Relationships =
  has_many :timetable_slots
  belongs_to :year

  # = Scopes =
  scope :by_no, order('no')

  def to_param
    no
  end

  def to_ASP
    "room(\"#{no}\")."
  end
end
