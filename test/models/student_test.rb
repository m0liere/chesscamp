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

  #rating in correct range
  should allow_value(0).for(:rating)
  should allow_value(3000).for(:rating)
  should allow_value(100).for(:rating)
  should allow_value(420).for(:rating)

  should_not allow_value(-1).for(:rating)
  should_not allow_value(50).for(:rating)
  should_not allow_value(5000).for(:rating)

end
