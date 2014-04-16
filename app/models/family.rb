class Family < ActiveRecord::Base
	#relationship
	has_many(:students)

	#validations
	validates_format_of :phone, :with => /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, :message => "should be 10 digits (area code needed) and delimited with dashes only"
  	validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format"

  	#must have phone and family name
  	validates_presence_of(:family_name)
  	validates_presence_of(:phone)

  	#scopes
  	scope :alphabetical, -> {order('family_name, parent_first_name')}
	scope :active, -> {where(active: true)}
	scope :inactive, -> {where(active: false)}
end
