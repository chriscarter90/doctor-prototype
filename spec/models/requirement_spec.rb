require 'spec_helper'

describe Requirement do
  describe "validations" do
    it { should validate_presence_of(:required) }
  end

  describe "relationships" do
    it { should belong_to(:degree_class) }
    it { should belong_to(:lecture_course) }
  end
end
