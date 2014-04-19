class Camp < ActiveRecord::Base
  #callbacks
  before_save :termination1, :if => :active_changed?
  before_destroy :termination2

  before_destroy :no_students_registered_destroy
  before_save :no_students_registered_invalid, :if => :active_changed?
  before_save :max_students_valid_for_loc



  # relationships
  belongs_to :curriculum
  belongs_to :location
  has_many :camp_instructors
  has_many :instructors, through: :camp_instructors
  has_many :registrations
  has_many :students, through: :registrations

  # validations
  validates_presence_of :curriculum_id, :time_slot, :start_date
  validates_numericality_of :cost, only_integer: true, greater_than_or_equal_to: 0
  validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "cannot be in the past", on:  :create
  validates_date :end_date, :on_or_after => :start_date
  validates_inclusion_of :time_slot, in: %w[am pm], message: "is not an accepted time slot"
  validates_numericality_of :max_students, only_integer: true, greater_than: 0, allow_blank: true
  validate :curriculum_is_active_in_the_system
  validate :camp_is_not_a_duplicate, on: :create
  validate :active_loc, on: :create
  validate :max_students_valid_for_loc
  validate :no_duplicates


  # scopes
  scope :alphabetical, -> { joins(:curriculum).order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :chronological, -> { order('start_date','end_date') }
  scope :morning, -> { where('time_slot = ?','am') }
  scope :afternoon, -> { where('time_slot = ?','pm') }
  scope :upcoming, -> { where('start_date >= ?', Date.today) }
  scope :past, -> { where('end_date < ?', Date.today) }
  scope :for_curriculum, ->(curriculum_id) { where("curriculum_id = ?", curriculum_id) }

  # instance methods
  def name
    self.curriculum.name
  end

  def already_exists?
    Camp.where(time_slot: self.time_slot, start_date: self.start_date).size == 1
  end

  # private
  def curriculum_is_active_in_the_system
    all_curric_ids = Curriculum.active.to_a.map(&:id)
    unless all_curric_ids.include?(self.curriculum_id)
      errors.add(:curriculum, "is not an active curriculum in the system")
    end
  end


  def camp_is_not_a_duplicate
    return true if self.time_slot.nil? || self.start_date.nil?
    if self.already_exists?
      errors.add(:time_slot, "already exists for start date and time slot")
    end
  end

    #helper function to make sure students register for camp with curriculum that suits their rating
  def camp_ratings_range
    ((self.curriculum.min_rating)..(self.curriculum.max_rating)).to_a
  end


  def termination1 
    if (self.active == false)
      cis = CampInstructor.where('camp_id = ?', self.id)
      cis.each do |i|
        i.destroy
      end
    end
  end

  def termination2 
    cis = CampInstructor.where('camp_id = ?', self.id)
    cis.each do |i|
      i.destroy
    end
  end

  #function to check camp is using an active location in the system
  def active_loc
    active_locs = Location.active.map{|i| i.id}
    unless active_locs.include?(self.location_id)
      errors.add(:camp, "camp must be associated with an active location in the system")
    end
  end

  #making sure students and camp dont exceed locations max capacity
  def max_students_valid_for_loc
    if(self.location != nil && self.max_students != nil)
      if self.location.max_capacity < self.max_students
        errors.add(:camp, "max students cannot exceed max capacity of a location")
      end
    end
  end

  #two fucntions to make sure camps can only be deleted OR 
  #made invalid if there are no students registered for the given camp
  def no_students_registered_destroy
    registered_for_camp = Registration.where('camp_id = ?', self.id)
    if registered_for_camp.size == 0
      return true
    end
    return false
  end

  def no_students_registered_invalid
      registered_for_camp = Registration.where('camp_id = ?', self.id)
      if registered_for_camp.size != 0
        self.active = true
        self.save!
      end
  end

  def no_duplicates
    Camp.all.each do |x|
      if (self.start_date == x.start_date) && (self.time_slot == x.time_slot) && (self.location == x.location) && (self.id != x.id)
          errors.add(:camp, "camp cannot have same start date, time slot, and location as another in the system")
      end
    end
  end
end
