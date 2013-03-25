class DegreeClass < ActiveRecord::Base

  attr_accessible :degreeyr, :letteryr, :title

  # = Validations =
  validates_presence_of :degreeyr, :letteryr, :title

  # = Relationships =
  has_many :requirements, :dependent => :destroy
  belongs_to :year

  # = Scopes =
  scope :by_degreeyr, order('degreeyr')

  def to_param
    degreeyr
  end
end
