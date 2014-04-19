class User < ActiveRecord::Base
	#relationships
	belongs_to :instructor

	#validations
	validates :username, uniqueness: {case_sensitive: false}
	validates :role, inclusion: {in: ['admin', 'instructor']}
	validate :connected_to_active_instructor, on: :create

	scope :alphabetical, -> {order('username')}
	scope :active, -> {where(active: true)}
	scope :inactive, -> {where(active: false)}

	#functions
	def connected_to_active_instructor
		unless Instructor.active.include?(self.instructor)
			errors.add(:user, 'when creating user, it must belong to active instructor')
		end
	end
	

end
