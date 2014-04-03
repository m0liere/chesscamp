class Location < ActiveRecord::Base
	#relationships
	belongs_to :camp

	#validations
	validates_presence_of(:name)
	validates_presence_of(:street_1)
	validates_presence_of(:zip)
	validates_presence_of(:max_capacity)

	validates_numericality_of(:max_students)
	validates_numericality_of(:latitude)
	validates_numericality_of(:longitude)

	validates :name, uniquenss: {case_sensitive: false}

	before_destroy :used_by_a_camp

	#scopes
	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }
	scope :alphabetical, -> { order('name') }

	def used_by_a_camp
		if self.camps.count == 0 return true
		else return false;
		end
	end


end