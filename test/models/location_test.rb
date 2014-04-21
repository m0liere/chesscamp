require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  #test relationships 
  should have_many(:camps)

  #test presence validations
  should validate_presence_of(:name)
  should validate_presence_of(:street_1)
  should validate_presence_of(:zip)
  should validate_presence_of(:max_capacity)

  # Validating zip...
  should allow_value("03431").for(:zip)
  should allow_value("15217").for(:zip)
  should allow_value("15090").for(:zip)
  
  should_not allow_value("fred").for(:zip)
  should_not allow_value("3431").for(:zip)
  should_not allow_value("15213-9843").for(:zip)
  should_not allow_value("15d32").for(:zip)
  should_not allow_value(nil).for(:zip)

  #test
  should validate_numericality_of(:max_capacity)

  context "create some locations" do
    setup do
      create_curriculums
      create_locs
      create_camps
    end 

    teardown do
      delete_curriculums
      delete_locs
      delete_camps

    end

    should "get latitude and longitude" do
      assert_in_delta(41.4413644, @home.latitude, 0.001)
      assert_in_delta(40.4435522, @fairfax.latitude, 0.001)
      assert_in_delta(43.0961489, @skid.latitude, 0.001)
      assert_in_delta(-73.73126239999999, @home.longitude, 0.001)
      assert_in_delta(-73.7817705, @skid.longitude, 0.001)
      assert_in_delta(-79.9559938, @fairfax.longitude, 0.001)
      @bad_loc = FactoryGirl.create(:location, street_1: 'dksjhfadslhflda', zip: '99999', name: 'jankalank')
      @bad_loc.destroy
      assert_equal ["Error with geocoding"], @bad_loc.errors[:base]
    end 

    should "not allow location that has been used to be deleted" do
      deny @home.destroy

    end

  end 

end
