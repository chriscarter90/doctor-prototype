class DegreeClass < ActiveRecord::Base

  attr_accessible :degreeyr, :letteryr, :title

  # = Validations =
  validates_uniqueness_of :degreeyr
  validates_presence_of :degreeyr, :letteryr, :title

  # = Relationships =
  has_many :requirements

  def to_param
    degreeyr
  end
end
