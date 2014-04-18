require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  #test relationships
  should have_one(:family).through(:student)

  should validate_presence_of(:camp_id)
end
