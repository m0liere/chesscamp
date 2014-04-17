class Student < ActiveRecord::Base
	#relationships
	#-------------------------------------------------------------------------------
	has_many(:registrations)
	belongs_to(:family)

	#validations	
	#-------------------------------------------------------------------------------
	#must have family_id, first_name, last_name
	validates_presence_of(:family_id)
	validates_presence_of(:first_name)
	validates_presence_of(:last_name)

	#numerical vaidations
	ratings_array = [0] + (100..3000).to_a
	validates :rating, numericality: {only_integer: true}, inclusion: {in: ratings_array}, presence: true

	validates_date :date_of_birth
	validates_numericality_of(:family_id)

	#scopes	
	#-------------------------------------------------------------------------------

	scope :alphabetical, -> {order('last_name, first_name')}
	scope :active, -> {where(active: true)}
	scope :inactive, -> {where(active: false)}
	
	#all students below given rating lvl
	scope :below_rating, -> (rating) {where('rating < ?', rating)}
	scope :at_or_above_rating, -> (rating) {where('rating >= ?',rating)}


	

	#callbacks
	#-------------------------------------------------------------------------------
	before_destroy :is_destroyable?
	validate :belongs_to_active_family? on: :create




	#additonal functions
	#-------------------------------------------------------------------------------
	private 
	#function to run before the save in the data base to set unrated players to 0
	def set_unrated
		if(self.rating.nil?)
			self.rating = 0;
		end
	end

	#name/proper_name/age
	def name
    	last_name + ", " + first_name
  	end
  
  	def proper_name
    	first_name + " " + last_name
  	end

	def age

	end

	#function to check student belongs to an active family in the system
	def belongs_to_active_family?
		active_families = Family.active.map{&:id}
		unless active_families.include?(self.family_id)
			errors.add(:base, "student must belong to an active family in the system")
			return false
		end
		return true
	end

	#function to be used in callback to ensure student cannot be deleted 
	def is_destroyable?
		false
	end
end
