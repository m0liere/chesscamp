class Registration < ActiveRecord::Base
	#relationships
	belongs_to(:camp)
	belongs_to(:student)

	#validations
	validates_presence_of(:camp_id)
	validates_presence_of(:student_id)
	validates_presence_of(:payment_status)


end
