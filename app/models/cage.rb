require './app/lib/park.rb'

class Cage < ApplicationRecord
  include ValidatableEnum

  has_many :dinosaurs, dependent: :destroy, inverse_of: :cage,
    before_add: [:check_max_capacity_on_add, :check_power_status_on_add],
    after_add: :increment_dinosaur_count,
    after_remove: :decrement_dinosaur_count

  attr_reader :dinosaur_count

  after_initialize :init

  before_save :check_power_status

  enum :power_status, Park::Cages::POWER_STATUS.zip(Park::Cages::POWER_STATUS.map(&:to_s)).to_h, default: :down, scopes: false

  MAX_CAPACITY = 100

  validates :max_capacity, numericality: { in: 1..100 }
  validates :tag, presence: true, uniqueness: true, allow_blank: false
  validates :location, presence: true, allow_blank: false
  validates :power_status, inclusion: { in: Park::Cages::POWER_STATUS.map(&:to_s),
                                        message: "Power status must be one of #{Park::Cages::POWER_STATUS.map(&:to_s)}" }

  # Commented this line because of the error below on Rails 7.0.4
  #validatable_enum :power_status

  # I was trying to override the error message if enum was invalid by following this blog:
  #   ActiveRecord::Enum validation in Rails API, https://medium.com/nerd-for-tech/using-activerecord-enum-in-rails-35edc2e9070f

  # Rails issue #44842:
  #   Enum conflict error message is misleading, https://github.com/rails/rails/issues/44842

  # This was the error message:
  #   /Users/chung/.rvm/gems/ruby-3.1.2/gems/activerecord-7.0.4/lib/active_record/enum.rb:301:in `raise_conflict_error':
  #   You tried to define an enum named "power_status" on the model "Cage", but this will generate a instance method "active?",
  #   which is already defined by another enum. (ArgumentError)

  # By just doing the following:
  #   > rails c
  #   > Cage.first

  private

  #attr_accessor :dinosaur_count

  def init
    self.dinosaur_count = 0 if self.dinosaur_count.blank?
  end

  def check_max_capacity_on_add(dinosaur)
    #binding.pry
    # NOTE: during unit testing, dinosaur_count is nil even though it shows that 
    #       it was set in init() above
    return if dinosaur_count.blank?
    if (dinosaur_count+1) > max_capacity
      errors.add(:base, "Unable to move to cage #{tag}. It's full (max capacity is #{max_capacity})")
      throw(:abort)
    end
  end

  def check_power_status_on_add(dinosaur)
    #binding.pry
    if power_status == :down
      errors.add(:base, "Unable to move to cage #{tag}. It's power status is down")
      throw(:abort)
    end
  end

  def check_power_status
    #binding.pry
    return unless power_status_changed?
    if power_status == :down && dinosaur_count > 0
      errors.add(:base, "Unable to power off cage #{tag}. It's not empty with #{dinosaur_count} dinosaurs contained")
      throw(:abort)
    end
  end

  def decrement_dinosaur_count(dinosaur)
    return if self.dinosaur_count.nil?
    self.dinosaur_count = 0 if self.dinosaur_count.blank?
    self.dinosaur_count -= 1 if self.dinosaur_count > 0
  end

  def increment_dinosaur_count(dinosaur)
    self.dinosaur_count = 0 if self.dinosaur_count.blank?
    self.dinosaur_count += 1
  end
end
