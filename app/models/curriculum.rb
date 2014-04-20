class Curriculum < ActiveRecord::Base
  # relationships
  has_many :camps

  # validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  ratings_array = [0] + (100..3000).to_a
  validates :min_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validates :max_rating, numericality: { only_integer: true }, inclusion: { in: ratings_array }
  validate :max_rating_greater_than_min_rating

  # scopes
  scope :alphabetical, -> { order('name') }
  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }
  scope :for_rating, ->(rating) { where("min_rating <= ? and max_rating >= ?", rating, rating) }

  #callback
  before_destroy :is_destroyable?
  before_save :inactive_curric_test



  #function to be used in callback to ensure curriculum cannot be deleted 
  def is_destroyable?
    false
  end


  def inactive_curric_test 
    Camp.upcoming.where('curriculum_id = ?', self.id).map { |i| i.id  }.each do |x|
      if(Registration.where('camp_id = ?', x).size > 0)
        self.active = true
        self.save!
        return
      end
    end
  end

  private
  def max_rating_greater_than_min_rating
    # only testing 'greater than' in this method, so...
    return true if self.max_rating.nil? || self.min_rating.nil?
    unless self.max_rating > self.min_rating
      errors.add(:max_rating, "must be greater than the minimum rating")
      return false
    end
    return true
  end



end
