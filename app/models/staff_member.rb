class StaffMember < ActiveRecord::Base

  attr_accessible :login, :salutation, :firstname, :lastname

  # = Validations =
  validates_uniqueness_of :login
  validates_presence_of :login, :salutation, :firstname, :lastname

  # = Relationships =
  has_many :lecturers
end
