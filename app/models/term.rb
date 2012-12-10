class Term < ActiveRecord::Base

  attr_accessible :no, :year

  # = Validations =
  validates_presence_of :no, :year
  validate :must_have_at_least_one_week

  # = Relationships =
  belongs_to :year
  has_many :weeks

  private
  def must_have_at_least_one_week
    errors.add(:weeks, :too_short, :count => 1) if weeks.blank?
  end
end
