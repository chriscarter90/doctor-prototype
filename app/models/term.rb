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

  # = Scopes =
  scope :in_order, order("no ASC")

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
      no_weeks.times do |w|
        self.weeks.build(:no => w)
      end
    elsif no_weeks > weeks_exist
      weeks_to_build = no_weeks - weeks_exist
      weeks_to_build.times do |w|
        self.weeks.build(:no => weeks_exist + w)
      end
    end
  end
end
