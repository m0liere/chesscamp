class Student < ActiveRecord::Base
	#relationships
	has_many(:registrations)
	belongs_to(:family)

	

end
