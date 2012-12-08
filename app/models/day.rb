class Day < ActiveRecord::Base

  attr_accessible :name, :no

  # = Validations =
  validates_presence_of :name, :no
  validates_uniqueness_of :no

  # = Scopes =
  scope :in_order, order("no ASC")
end
