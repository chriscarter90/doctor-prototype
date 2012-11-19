require 'spec_helper'

describe Lecturer do
  describe "validations" do
    it { should validate_presence_of(:staff_member_id) }
    it { should validate_presence_of(:lecture_course_id) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:staffhours) }
    it { should validate_presence_of(:term) }
  end

  describe "relationships" do
    it { should belong_to(:staff_member) }
    it { should belong_to(:lecture_course) }
  end
end
