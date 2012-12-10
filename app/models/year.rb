class Year < ActiveRecord::Base

  attr_accessible :no

  # = Validations =
  validates :no, :presence => true, :uniqueness => true
  validate :must_have_at_least_one_term

  def must_have_at_least_one_term
    errors.add(:terms, :too_short, :count => 1) if terms.blank?
  end

  # = Relationships =
  has_many :terms
end
