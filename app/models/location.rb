class Location < ActiveRecord::Base
	#callback
	before_destroy :used_by_a_camp
	before_save :find_loc_coordinates

	#relationships
	has_many :camps

	#presence validations
	validates_presence_of(:name)
	validates_presence_of(:street_1)
	validates_presence_of(:zip)
	validates_presence_of(:max_capacity)

	#numericality validations
	validates_numericality_of(:max_capacity)
	validates :name, uniqueness: {case_sensitive: false}

	#format validations
	validates_format_of :zip, with: /\A\d{5}\z/, message: "should be five digits long", allow_blank: true


	us_state_abbrevs = ['AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT', '
		DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID', 'IL', 'IN', 'IA', 
		'KS', 'KY', 'LA', 'ME', 'MH', 'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 
		'MT', 'NE', 'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP', 'OH', 
		'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC', 'SD', 'TN', 'TX', 'UT', 
		'VT', 'VI', 'VA', 'WA', 'WV', 'WI', 'WY']
	validates :state, length: {is: 2}, inclusion: {in: us_state_abbrevs}


	#geocoder
	def find_loc_coordinates
    	coord = Geocoder.coordinates("#{name}, #{street_1}, #{street_2}, #{state}, #{zip}")
    	if coord
      		self.latitude = coord[0]
      		self.longitude = coord[1]
    	else 
      		errors.add(:base, "Error with geocoding")
    	end
    	coord
  	end



	#scopes
	scope :active, -> { where(active: true) }
	scope :inactive, -> { where(active: false) }
	scope :alphabetical, -> { order('name') }

	def used_by_a_camp
		if self.camps.count == 0 
			return true
		else return false
		end
	end


end