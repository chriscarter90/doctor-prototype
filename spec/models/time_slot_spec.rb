require 'spec_helper'

describe TimeSlot do
  describe "validations" do
    it { should validate_presence_of(:day) }
    it { should validate_presence_of(:start_hour) }
  end

  describe "relationships" do
    it { should belong_to(:day) }
  end
end
