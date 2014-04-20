class Registration < ActiveRecord::Base
	#relationships
	belongs_to :camp
	belongs_to :student
	has_one :family, through: :student

	#validations
	validates_presence_of(:camp_id)
	validates_presence_of(:student_id)
	validates_presence_of(:payment_status)

	validates :payment_status, inclusion: {in: ['full', 'deposit']}
	validates :points_earned, numericality:{greater_than_or_equal_to: 0, only_integer: true}

	validate :can_register_for_camp?
	validate :active_student
	validate :active_camp

	#scopes
	#---------------------------------------------
	scope :deposit_only, -> {where('payment_status = ?', 'deposit')}
	scope :paid, -> {where('payment_status = ?', 'full')} 

	#function to test that the respective student it active in the system
	def active_student
		unless Student.active.include?(self.student)
			errors.add(:registration, "Registration must me associated with an active student")
		end
	end
	#function to test that the respective camp it active in the system
	def active_camp
		unless Camp.active.include?(self.camp)
			errors.add(:registration, "Registration must me associated with an active camp")
		end
	end

	#function making sure students camp selection is good for their rating
	def can_register_for_camp?
		if self.camp != nil 
			return self.camp.camp_ratings_range.include?(self.student.rating)
		end
	end


end
