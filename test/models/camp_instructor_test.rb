require 'test_helper'

class CampInstructorTest < ActiveSupport::TestCase
  # test relationships
  should belong_to(:camp)
  should belong_to(:instructor)

  # test validations
  should validate_presence_of(:camp_id)
  should validate_presence_of(:instructor_id)
  should validate_numericality_of(:camp_id)
  should validate_numericality_of(:instructor_id)
  should_not allow_value(-1).for(:camp_id)
  should_not allow_value(0).for(:camp_id)
  should_not allow_value(50.50).for(:camp_id)
  should_not allow_value(-1).for(:instructor_id)
  should_not allow_value(0).for(:instructor_id)
  should_not allow_value(50.50).for(:instructor_id)

  # set up context
  include Contexts
  context "Creating a camp instructor context" do
    setup do 
      create_curriculums
      create_instructors
      create_locs
      create_camps
      create_camp_instructors
    end
    
    teardown do
      delete_curriculums
      delete_instructors
      delete_locs
      delete_camps
      delete_camp_instructors
    end

    should "not allow the same instructor to assigned twice to the same camp" do
      bad_assignment = FactoryGirl.build(:camp_instructor, instructor: @mark, camp: @camp4)
      deny bad_assignment.valid?
    end

    should "not allow an instructor to assigned an inactive camp" do
      bad_assignment = FactoryGirl.build(:camp_instructor, instructor: @mark, camp: @camp3)
      deny bad_assignment.valid?
    end

    should "not allow an inactive instructor to assigned to a camp" do
      bad_assignment = FactoryGirl.build(:camp_instructor, instructor: @rachel, camp: @camp4)
      deny bad_assignment.valid?
    end
  end
end
