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

  #test
  should validate_numericality_of(:max_capacity)

end
