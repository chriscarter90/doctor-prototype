class Clash < ActiveRecord::Base

  attr_accessible :year

  # = Validations =
  validates_presence_of :year

  # = Relationships =
  has_and_belongs_to_many :lecture_courses
  belongs_to :year

  # = Scopes =

  scope :for_year, ->(year) do
    where("clashes.year_id = ?", year.id)
  end
end
