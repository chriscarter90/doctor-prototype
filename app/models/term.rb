class Term < ActiveRecord::Base

  attr_accessible :no, :year
  attr_accessor :no_weeks

  before_save :create_weeks

  # = Validations =
  validates_presence_of :no, :year
  validate :must_have_weeks

  # = Relationships =
  belongs_to :year
  has_many :weeks

  private
  def must_have_weeks
    if self.no_weeks.nil? || self.no_weeks < 1
      errors.add(:no_weeks, "must be a positive integer")
    end
  end

  def create_weeks
    self.weeks = []
    self.no_weeks.times do |w|
      self.weeks.build(:no => w)
    end
  end
end
