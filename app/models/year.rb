class Year < ActiveRecord::Base

  attr_accessible :no, :terms_attributes

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

  # = Scopes =
  scope :in_order, order("no ASC")

  def to_param
    no
  end
end
