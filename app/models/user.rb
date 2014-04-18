class User < ActiveRecord::Base
	#relationships
	belongs_to(:instructor)

	#validations
	validates :username, uniqueness: {case_sensitive: false}
	validates :role, inclusion: {in: ['admin', 'instructor']}

	#functions
	

end
