
require 'rails_helper'

describe Course, :type => :model do
  describe "validations" do

    before(:all) do
      @teacher = create(:user, user_type: 'teacher')
    end

    it "is valid with valid attributes" do
      expect(create(:course, teacher: @teacher)).to be_valid
    end
  end
end
