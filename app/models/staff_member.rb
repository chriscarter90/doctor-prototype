class StaffMember < ActiveRecord::Base

  attr_accessible :login, :salutation, :firstname, :lastname

  # = Validations =
  validates_presence_of :login, :salutation, :firstname, :lastname

  # = Relationships =
  has_many :lecturers, :dependent => :destroy
  has_many :lecture_courses, :through => :lecturers
  has_many :course_weeks, :dependent => :destroy
  belongs_to :year

  # = Scopes =
  scope :by_login, order('login')

  def to_param
    login
  end

  def full_name
    "#{salutation} #{firstname} #{lastname}"
  end

  def display
    "#{full_name} (#{login})"
  end
end
