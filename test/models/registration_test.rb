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

  should_not allow_value('dsafjk').(:payment_status)
  should_not allow_value(nil).(:payment_status)
  should_not allow_value(666).(:payment_status)

  should validate_numericality_of(:points_earned).only_integer()

  should allow_value(0).for(:points_earned)
  should allow_value(100).for(:points_earned)
  should_not allow_value(-1).for(:points_earned)
  should_not allow_value(nil.for(:points_earned)
  should_not allow_value('jank').for(:points_earned)



end
