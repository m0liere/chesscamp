class Instructor < ActiveRecord::Base
  # relationships
  has_many :camp_instructors
  has_many :camps, through: :camp_instructors

  # validations
  validates_presence_of :first_name, :last_name, :phone
  validates_format_of :phone, :with => /\A(\d{10}|\(?\d{3}\)?[-. ]\d{3}[-.]\d{4})\z/, :message => "should be 10 digits (area code needed) and delimited with dashes only"
  validates_format_of :email, :with => /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, :message => "is not a valid format"

  # scopes
  scope :alphabetical, -> { order('last_name, first_name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :needs_bio, -> { where('bio IS NULL') }
  # scope :needs_bio, -> { where(bio: nil) }  # this also works...

  # class methods
  def self.for_camp(camp)
    # the 'instructive way'... (which I told you if you asked me for help)
    CampInstructor.where(camp_id: camp.id).map{ |ci| ci.instructor }
    # the easy way... 
    # camp.instructors
  end

  # instance methods
  before_save :reformat_phone

  def name
    last_name + ", " + first_name
  end
  
  def proper_name
    first_name + " " + last_name
  end

  private
  def reformat_phone
    # shorter, more direct way than in PATS
    self.phone = self.phone.to_s.gsub(/[^0-9]/,"")
  end
  
end
