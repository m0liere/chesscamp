require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  should belong_to(:instructor)

  should validate_uniqueness_of(:username).case_insensitive()

  should allow_value('admin').for(:role)
  should allow_value('instructor').for(:role)
  should_not allow_value("rankalank").for(:role)
  should_not allow_value(nil).for(:role)
  should_not allow_value(66).for(:role)

  context "make some users" do
  	setup do
  		create_instructors
  		create_more_instructors
  		create_users
  	end

  	teardown do
  		delete_instructors
  		delete_more_instructors
  		delete_users
  	end

  	should "show there is 1 inactive user in the system" do
  		assert_equal 1, User.inactive.size
  		assert_equal ['agentborini'], User.inactive.map { |i| i.username  }
  	end

  	should "show there is  2 active users in the system" do
  		assert_equal 2, User.active.size
  		assert_equal ['luis7suarez', 'redordead'], User.active.map { |i| i.username  }.sort
  	end

  	should "show all instructors in alphabetical order" do
  		assert_equal ['agentborini' , 'luis7suarez', 'redordead'], User.alphabetical.map { |i| i.username  }.sort

  	end

  	should "make sure users can only be created with active instructor" do
  		@bad_user = FactoryGirl.build(:user, instructor: @rachel)
  		deny @bad_user.valid?
  	end

  end

end
