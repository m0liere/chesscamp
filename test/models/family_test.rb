require 'test_helper'

class FamilyTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test relationships
  should  have_many(:students)
  should  have_many(:registrations).through(:students)

  #presence validations test
  should validate_presence_of(:family_name)
  should validate_presence_of(:phone)

  #test format for phone and email 
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  should allow_value("4122683259").for(:phone)
  should allow_value("412-268-3259").for(:phone)
  should allow_value("412.268.3259").for(:phone)
  should allow_value("(412) 268-3259").for(:phone)
  
  should_not allow_value("2683259").for(:phone)
  should_not allow_value("4122683259x224").for(:phone)
  should_not allow_value("800-EAT-FOOD").for(:phone)
  should_not allow_value("412/268/3259").for(:phone)
  should_not allow_value("412-2683-259").for(:phone)


  context "create some families from south park" do
  	setup do
  		create_families
  		@pirrip = FactoryGirl.create(:family, family_name: 'Pirrip', active: false)
  	end

  	teardown do
  		delete_families
  		@pirrip.destroy
  	end 

  	should "correctly assess if a family is destroyable" do
      deny @cartman.is_destroyable?
    end

  	should "show there are active 4 families in the system" do
		assert_equal 4, Family.active.size
		assert_equal ['Brovslovski', 'Cartman', 'Marsh', 'Mccormick'], Family.active.map{|i| i.family_name}.sort
	end

	should "show there is 1 inactive family in the system" do
		assert_equal 1, Family.inactive.size
		assert_equal ['Pirrip'], Family.inactive.map{|i| i.family_name}
	end

	should "show all families in alphabetical order" do 
		assert_equal ['Brovslovski', 'Cartman', 'Marsh', 'Mccormick', 'Pirrip'], Family.alphabetical.map { |i| i.family_name  }
	end

  end

end
