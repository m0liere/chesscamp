require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test relationships
  should belong_to(:camp)
  should belong_to(:student)
  should have_one(:family).through(:student)

  should validate_presence_of(:camp_id)
  should validate_presence_of(:student_id)
  should validate_presence_of(:payment_status)

  should allow_value('full').for(:payment_status)
  should allow_value('deposit').for(:payment_status)

  should_not allow_value('dsafjk').for(:payment_status)
  should_not allow_value(nil).for(:payment_status)
  should_not allow_value(666).for(:payment_status)

  should validate_numericality_of(:points_earned).only_integer()

  should allow_value(0).for(:points_earned)
  should allow_value(100).for(:points_earned)
  should_not allow_value(-1).for(:points_earned)
  should_not allow_value(nil).for(:points_earned)
  should_not allow_value('jank').for(:points_earned)
  should_not allow_value(5.555).for(:points_earned)

  context "create dem registrations" do
  	setup do
  		create_curriculums
  		create_locs
  		create_camps
  		create_families
  		create_students
  		create_registrations
  	end

  	teardown do
  		delete_curriculums
  		delete_locs
  		delete_camps
  		delete_families
  		delete_students
  		delete_registrations
  	end

  	should "only allow registrations with active students" do
  		@tolken = FactoryGirl.create(:student, active: false, family: @cartman, first_name: 'Tolken', rating: 600)
  		@bad_reg = FactoryGirl.build(:registration, student: @tolken, camp: @camp1)
  		deny @bad_reg.valid?
  		@tolken.delete
  	end

  	should "only allow registrations with active camps" do
  		@bad_reg = FactoryGirl.build(:registration, student: @stan, camp: @camp3)
  		deny @bad_reg.valid?
  	end

  	should "make sure student is registering for a camp their rating qualifies them for" do
  		@bad_reg = FactoryGirl.build(:registration, student: @eric, camp: @camp1)
  		deny @bad_reg.valid?
  	end

  end 


end
