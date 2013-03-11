class Room < ActiveRecord::Base

  attr_accessible :no, :capacity, :year

  # = Validations =
  validates_presence_of :no, :capacity, :year
  validates_uniqueness_of :no

  # = Relationships =
  has_many :timetable_slots
  belongs_to :year

  # = Scopes =
  scope :by_no, order('no')

  def to_param
    no
  end
end
