class Year < ActiveRecord::Base

  attr_accessible :no, :terms_attributes, :timetable_generated, :timetable_generating

  # = Validations =
  validates :no, :presence => true, :uniqueness => true

  # = Relationships =
  has_many :terms, :dependent => :destroy
  has_many :course_weeks, :through => :terms
  has_many :weeks, :through => :terms
  accepts_nested_attributes_for :terms
  has_many :clashes
  has_many :unclashables
  has_many :lecture_courses, :dependent => :destroy
  has_many :staff_members, :dependent => :destroy
  has_many :degree_classes, :dependent => :destroy
  has_many :rooms, :dependent => :destroy
  has_many :lecturers, :through => :lecture_courses
  has_many :requirements, :through => :lecture_courses
  has_many :timetable_slots, :through => :weeks

  # = Scopes =
  scope :in_order, order("no ASC")

  def to_param
    no
  end

  def create_directory
    master_dir = Rails.root.join('ASP', 'master')
    FileUtils::mkdir_p(Rails.root.join('ASP', no.to_s))
    FileUtils::cp(master_dir + 'timetable.lp', Rails.root.join('ASP', no.to_s, 'timetable.lp'))
    FileUtils::cp(master_dir + 'precisely.lp', Rails.root.join('ASP', no.to_s, 'precisely.lp'))
    FileUtils::cp(master_dir + 'preferences.lp', Rails.root.join('ASP', no.to_s, 'preferences.lp'))
  end
end
