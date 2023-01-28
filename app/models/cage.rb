# frozen_string_literal: true

require './app/lib/park'

class Cage < ApplicationRecord
  has_many :dinosaurs, dependent: :nullify, inverse_of: :cage,
                       before_add: [:check_max_capacity?,
                                    :check_power_status_on_add?,
                                    :check_same_species?]

  before_destroy :check_dinosaurs_count?
  before_save :check_power_status?
  after_save :update_dinosaurs_count

  enum :power_status, Park::Cages::POWER_STATUS.zip(Park::Cages::POWER_STATUS.map(&:to_s)).to_h, default: :down.to_s, scopes: false

  validates :max_capacity, numericality: { in: 1..100 }
  validates :tag, presence: true, uniqueness: true, allow_blank: false
  validates :location, presence: true, allow_blank: false
  validates :power_status, inclusion: { in: Park::Cages::POWER_STATUS.map(&:to_s),
                                        message: "Power status must be one of #{Park::Cages::POWER_STATUS.map(&:to_s)}" }

  private

  def update_dinosaurs_count
    # NOTE: Attempted to avoid a DB count by tracking `dinosaurs_count` with `init`, `after_add`, and `after_remove` callbacks
    # with no success, see work in branch: https://github.com/developertogo/jurassic-park/tree/uniqueness-enum-validation
    update_column(:dinosaurs_count, dinosaurs.count) # rubocop:disable Rails/SkipsModelValidations
  rescue StandardError
    errors.add(:base, "Unable to update cage #{tag} dinosaurs_count")
    raise ActiveRecord::RecordInvalid, self
  end

  def check_max_capacity?(_dinosaur)
    return unless (dinosaurs_count + 1) > max_capacity

    errors.add(:base, "Unable to move to cage #{tag}. It's full (max capacity is #{max_capacity})")
    raise ActiveRecord::RecordInvalid, self
  end

  def check_power_status_on_add?(_dinosaur)
    return unless power_status == :down.to_s

    errors.add(:base, "Unable to move to cage #{tag}. It's power status is down")
    raise ActiveRecord::RecordInvalid, self
  end

  def check_same_species?(dinosaur)
    return unless dinosaurs_count.positive? && dinosaur.diet != dinosaurs[0].diet

    errors.add(:base, "Unable to move to cage #{tag}. It contains #{dinosaurs[0].diet}, a different species")
    raise ActiveRecord::RecordInvalid, self
  end

  def check_power_status?
    return unless power_status == :down.to_s && dinosaurs_count.positive?

    errors.add(:base, "Unable to power off cage #{tag}. It's not empty, it contains #{dinosaurs_count} dinosaurs")
    raise ActiveRecord::RecordInvalid, self
  end

  def check_dinosaurs_count?
    return unless dinosaurs_count.positive?

    errors.add(:base, "Unable to delete cage #{tag}. It's not empty, it contains #{dinosaurs_count} dinosaurs")
    raise ActiveRecord::RecordInvalid, self
  end
end
