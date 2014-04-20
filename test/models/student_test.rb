require 'test_helper'

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test relationships
  should have_many(:registrations)
  should belong_to(:family)

  #test validations
  should validate_presence_of(:family_id)
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)

  should validate_numericality_of(:rating).only_integer()

  #rating in correct range
  should allow_value(0).for(:rating)
  should allow_value(3000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(420).for(:rating)

  should_not allow_value(-1).for(:rating)
  should_not allow_value(50).for(:rating)
  should_not allow_value(5000).for(:rating)
  should_not allow_value('rank').for(:rating)
  should_not allow_value(5.765).for(:rating)

  should allow_value(18.years.ago.to_date).for(:date_of_birth)
  #should_not allow_value(17.years.ago).for(:date_of_birth)
  should_not allow_value(-1).for(:date_of_birth)
  should_not allow_value(50).for(:date_of_birth)
  should_not allow_value(nil).for(:date_of_birth)
  should_not allow_value('rank').for(:date_of_birth)
  should_not allow_value(5.765).for(:date_of_birth)

  context "create 4 students" do
  	setup do
  		create_students
  		create_families
  	end

  	teardown do
  		delete_students
  		delete_families
  	end

  	should "show that there are 3 active students" do
  		assert_equal 3, Student.active.size
  		assert_equal ['Eric', 'Kyle', 'Stan'], Student.active.map{|i| i.first_name}.sort
  	end 

  	should "show that there is 1 inactive student" do
  		assert_equal 1, Student.inactive.size
  		assert_equal ['Kenny'], Student.inactive.map{|i| i.first_name}.sort
  	end 

	should "show all students in alphabetical order" do
  		assert_equal ['Kyle', 'Eric', 'Stan', 'Kenny'], Student.alphabetical.map{|i| i.first_name}
  	end 

  	should "show that there are 2 students with ratings below 200" do
  		assert_equal 2, Student.below_rating(200).size
  		assert_equal ['Eric', 'Kenny'], Student.below_rating(200).map{|i| i.first_name}.sort
  	end	

  	should "show that there are 2 students with ratings at or above 1000" do
  		assert_equal 2, Student.at_or_above_rating(400).size
  		assert_equal ['Kyle', 'Stan'], Student.at_or_above_rating(400).map{|i| i.first_name}.sort
  	end

  	should "show correct name for given student" do
  		assert_equal 'Cartman, Eric', @eric.name
  	end

  	should "show correct proper name for given student" do
  		assert_equal 'Eric Cartman', @eric.proper_name
  	end

  	should "show correct age for a given student" do
  		assert_equal 9, @eric.age
  	end

  	should "not allow student to be created if not part of an active family" do
  		@pirrip = FactoryGirl.create(:family, family_name: 'Pirrip', active: false)
  		@pip = FactoryGirl.build(:student, family: @pirrip, first_name: 'Philip', last_name: 'Pirrip')
  		#assert_equal ["student must belong to an active family in the system"], @pip.errors[:base]
  		deny @pip.valid?
  		@pirrip.delete
  	end 

  	should "set unrated players to 0 before saving to database" do
  		assert_equal 0, @kenny.rating
  	end

  	should "correctly assess if a student is destroyable" do
      deny @eric.is_destroyable?
    end

  end 

end
