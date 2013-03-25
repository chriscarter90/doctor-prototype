class Week < ActiveRecord::Base

  attr_accessible :no, :term, :date

  # = Validations =
  validates_presence_of :no, :term, :date

  # = Relationships =
  belongs_to :term
  has_many :course_weeks, :dependent => :destroy
  has_many :timetable_slots, :dependent => :destroy

  def to_ASP
    "week_term(#{no}, #{term.no})."
  end

end
