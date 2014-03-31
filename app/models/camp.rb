class Camp < ActiveRecord::Base
  # relationships
  belongs_to :curriculum
  has_many :camp_instructors
  has_many :instructors, through: :camp_instructors

  # validations
  validates_presence_of :curriculum_id, :time_slot, :start_date
  validates_numericality_of :cost, only_integer: true, greater_than_or_equal_to: 0
  validates_date :start_date, :on_or_after => lambda { Date.today }, :on_or_after_message => "cannot be in the past", on:  :create
  validates_date :end_date, :on_or_after => :start_date
  validates_inclusion_of :time_slot, in: %w[am pm], message: "is not an accepted time slot"
  validates_numericality_of :max_students, only_integer: true, greater_than: 0, allow_blank: true
  validate :curriculum_is_active_in_the_system
  validate :camp_is_not_a_duplicate, on: :create

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


end
