class Term < ActiveRecord::Base

  attr_accessible :no, :year, :start_date
  attr_accessor :no_weeks

  before_save :create_weeks

  # = Validations =
  validates_presence_of :no, :year, :start_date
  validate :must_have_weeks

  # = Relationships =
  belongs_to :year
  has_many :weeks, :dependent => :destroy
  has_many :course_weeks, :through => :weeks

  # = Scopes =
  scope :in_order, order("no ASC")

  def to_param
    no
  end

  def to_ASP
    "term(#{no})."
  end

  private
  def must_have_weeks
    if self.no_weeks.nil? || self.no_weeks < 1
      errors.add(:no_weeks, "must be a positive integer")
    end
  end

  def create_weeks
    weeks_exist = self.weeks.size
    if no_weeks < weeks_exist
      self.weeks = []
      week_1_date = start_date.monday? ? start_date : (start_date + 1.week).beginning_of_week
      1.upto(no_weeks) do |w|
        self.weeks.build(:no => w, :date => week_1_date + (w - 1).weeks)
      end
    elsif no_weeks > weeks_exist
      week_1_date = start_date.monday? ? start_date : (start_date + 1.week).beginning_of_week
      (weeks_exist + 1).upto(no_weeks) do |w|
        self.weeks.build(:no => w, :date => week_1_date + (w - 1).weeks)
      end
    end
  end
end
