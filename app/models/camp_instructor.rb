class CampInstructor < ActiveRecord::Base
  # relationships
  belongs_to :camp
  belongs_to :instructor

  # validations
  validates :camp_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validates :instructor_id, presence: true, numericality: { greater_than: 0, only_integer: true }
  validate :instructor_is_not_already_assigned_to_camp
  validate :instructor_is_active_in_system
  validate :camp_is_active_in_system

  private
  def instructor_is_not_already_assigned_to_camp
    unless CampInstructor.where(camp_id: self.camp_id, instructor_id: self.instructor_id).to_a.empty?
      errors.add(:base, "Instructor has already been assigned to this camp")
    end
  end

  def instructor_is_active_in_system
    all_instructors_ids = Instructor.active.to_a.map(&:id)
    unless all_instructors_ids.include?(self.instructor_id)
      errors.add(:base, "Instructor is not an active instructor in the system")
    end
  end

  def camp_is_active_in_system
    all_camps_ids = Camp.active.to_a.map(&:id)
    unless all_camps_ids.include?(self.camp_id)
      errors.add(:base, "Camp is not an active camp in the system")
    end   
  end
end
