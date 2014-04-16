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
	validates :rating, numericality: {only_integer: true}, inclusion: {in: ratings_array}, presence: true

	validates_date :date_of_birth
	validates_numericality_of(:family_id)

	#scopes
	scope :alphabetical, -> {order('last_name, first_name')}
	scope :active, -> {where(active: true)}
	scope :inactive, -> {where(active: false)}
	#all students below given rating lvl
	scope :below_rating, -> (rating) {where('rating < ?', rating)}
	scope :at_or_above_rating, -> (rating) {where('rating >= ?',rating)}


	#additonal functions
	
	#function to run before the save in the data base to set unrated players to 0
	def set_unrated
		if(self.rating.nil?)
			self.rating = 0;
		end
	end

	#name
	#propername
	#age

	def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

	def age

	end
end
