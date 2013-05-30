class Room < ActiveRecord::Base

  attr_accessible :no, :capacity, :year, :room_type, :size

  # = Validations =
  validates_presence_of :no, :capacity, :year, :room_type, :size

  # = Relationships =
  has_many :timetable_slots
  belongs_to :year

  # = Scopes =
  scope :by_no, order('no')

  def to_param
    no
  end

  def to_ASP
    "#{room_type}_room(\"#{no}\")."
  end

  def size_to_ASP
    "room_size(\"#{no}\", #{size}\)."
  end
end
