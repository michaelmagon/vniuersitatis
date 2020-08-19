
require 'rails_helper'
FactoryBot.find_definitions

describe Course, :type => :model do
  describe "validations" do

    before(:all) do
      @teacher = create(:user, email:'student_user@mail.com',user_type: 'teacher')
    end

    it "is valid with valid attributes" do
      expect(Course.new(id: 1, title: 'Title', content: 'content',
        summary: 'summary', teacher_id: @teacher.id, slug:'title')).to be_valid
    end
  end


end
