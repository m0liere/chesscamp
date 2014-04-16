class Student < ActiveRecord::Base
	#relationships
	has_many(:registrations)
	belongs_to(:family)

	#validations
	#must have family_id, first_name, last_name
	validates_presence_of(:family_id)
	validates_presence_of(:first_name)
	validates_presence_of(:last_name)

	#numerical vaidations
	ratings_array = [0] + (100..3000).to_a
	validates :rating, numericality: {only_integer: true}, inclusion: {in: ratings_array}


	#custom validiatons
	#student must belong to a family that is ACTIVE in the system

end
