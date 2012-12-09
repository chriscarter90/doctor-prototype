class Year < ActiveRecord::Base

  attr_accessible :no

  # = Validations =
  validates :no, :presence => true, :uniqueness => true
end
