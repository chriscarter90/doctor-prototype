class Term < ActiveRecord::Base

  attr_accessible :no, :year

  # = Validations =
  validates_presence_of :no, :year

  # = Relationships =
  belongs_to :year
  has_many :weeks
end
