class Week < ActiveRecord::Base

  attr_accessible :no, :term

  # = Validations =
  validates_presence_of :no, :term

  # = Relationships =
  belongs_to :term
end
