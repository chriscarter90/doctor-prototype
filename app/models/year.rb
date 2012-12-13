class Year < ActiveRecord::Base

  attr_accessible :no, :terms_attributes

  # = Validations =
  validates :no, :presence => true, :uniqueness => true

  # = Relationships =
  has_many :terms, :dependent => :destroy
  accepts_nested_attributes_for :terms

  # = Scopes =
  scope :in_order, order("no ASC")

  def to_param
    no
  end
end
