class Room < ActiveRecord::Base

  attr_accessible :no, :capacity

  # = Validations =
  validates_presence_of :no, :capacity
  validates_uniqueness_of :no

  # = Scopes =
  scope :by_no, order('no')

  def to_param
    no
  end
end
