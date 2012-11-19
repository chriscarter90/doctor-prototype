require 'spec_helper'

describe LectureCourse do
  describe "validations" do
    # Primary key
    it { should validate_presence_of(:code) }
    it { should validate_uniqueness_of(:code) }

    # Other fields
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:term) }
    it { should validate_presence_of(:classes) }
    it { should validate_presence_of(:lecturehours) }
    it { should validate_presence_of(:tutorialhours) }
    it { should validate_presence_of(:labhours) }
    it { should validate_presence_of(:weeklyhours) }
    it { should validate_presence_of(:popestimate) }
    it { should validate_presence_of(:popregistered) }
  end

  describe "relationships" do
    it { should have_many(:requirements) }
    it { should have_many(:lecturers) }
  end
end
