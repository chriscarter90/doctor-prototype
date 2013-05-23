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

  def to_ASP
    asp = ""
    lecture_courses.combination(2).to_a.each do |combination|
      asp << "clash_wanted(\"#{combination[0].code}\", \"#{combination[1].code}\").\n"
    end
    asp
  end
end
