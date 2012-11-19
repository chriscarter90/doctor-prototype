require 'spec_helper'

describe DegreeClass do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:degreeyr) }
    it { should validate_uniqueness_of(:degreeyr) }

    # Other fields
    it { should validate_presence_of(:letteryr) }
    it { should validate_presence_of(:title) }
  end

  describe "relationships" do
    it { should have_many(:requirements) }
  end
end
