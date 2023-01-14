class Cage < ApplicationRecord
  include ValidatableEnum

  has_many :dinosaurs, dependent: :destroy, inverse_of: :cage, 
    before_add: [check_max_capacity_on_add, check_power_status_on_add]
    after_add: increment_dinasour_count
    after_remove:  decrement_dinasour_count

  attr_reader :dinosaur_count

  before_save :check_power_status

  POWER_STATUS = %i[active down]
  enum power_status: POWER_STATUS, _default: 'down' 

  MAX_CAPACITY = 100

  validates :max_capacity, numericality: { in: 1..100 }
  validates :tag, presence: true, uniqueness: true, allow_blank: false
  validates :location, presence: true, allow_blank: false
  validates :power_status, includes: { in: POWER_STATUS.keys,
                                       message: "Species must be one of #{SPECIES.keys}" } 
  validatable_enum :power_status

  private

  def check_max_capacity_on_add(dinosaur)
    if dinasour_count+1 > max_capacity
      errors.add(:base, "Unable to move to cage #{tag}. It's full (max capacity is #{max_capacity})")
      throw(:abort)
    end
  end

  def check_power_status_on_add(dinosaur)
    if power_status == :down 
      errors.add(:base, "Unable to move to cage #{tag}. It's power status is down" 
      throw(:abort)
    end
  end

  def check_power_status(dinosaur)
    return unless power_status_changed?
    if power_status == :down && dinasour_count > 0
      errors.add(:base, "Unable to power off cage #{tag}. It's not empty with #{dinasour_count} dinosaurs contained")
      throw(:abort)
    end
  end

  def decrement_dinasour_count(dinosaur)
    dinasour_count -= 1
  end

  def increment_dinasour_count(dinosaur)
    dinasour_count += 1
  end
end
