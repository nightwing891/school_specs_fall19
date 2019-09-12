require 'rails_helper'

RSpec.describe Student, type: :model do
  describe 'attributes' do
    it { should respond_to :name }
    it { should respond_to :student_number }
    it { should respond_to :gpa }
    it { should belong_to(:school) }
  end

  describe "association" do
    it { should belong_to(:school) }
  end

  describe "uniqueness" do
    before(:each) do
      school = School.create!(name: 'foo', address: '123', principal: 'mt')
      student = Student.create!(name: 'foo', student_number: 1234, gpa: 1.23, school_id: 1)
      subject { Student.new(name: 'foo', student_number: 1234, gpa: 1.23, school_id: 1) }
    end
    
    it { should validate_uniqueness_of(:name) }
  end  
  
  describe "numericality" do
    before(:each) do
      @school = School.create(name: 'foo', address: '123', principal: 'mt')
      @student = Student.create(name: 'bob', student_number: 1234, gpa: 1.23, school_id: 1)
    end
    
     it { should validate_numericality_of(:student_number) }
  end end
