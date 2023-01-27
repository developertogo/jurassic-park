# frozen_string_literal: true

require './app/lib/park'

class Dinosaur < ApplicationRecord
  # NOTE: attempted to use counter_cache but cage.dinosaurs_count becomes -1
  # When moving dinosaur from the "from" cage containing just this dinosaur.
  # Expected the count = 0, but not -1; even from_cage.dinosaurs.size returns -1
  # belongs_to :cage #, counter_cache: true
  belongs_to :cage

  before_save :update_diet

  # Workaround: using this callback to update cage.dinosaurs_count 'cause read line 6 above
  after_save :update_dinosaurs_count

  enum :diet, Park::Dinosaurs::DIET.zip(Park::Dinosaurs::DIET.map(&:to_s)).to_h, scopes: false
  enum :species, Park::Dinosaurs::SPECIES.zip(Park::Dinosaurs::SPECIES.map(&:to_s)).to_h, scopes: false

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :species, inclusion: { in: Park::Dinosaurs::SPECIES.map(&:to_s),
                                   message: 'Invalid species' }

  private

  def update_dinosaurs_count
    cage.update_dinosaurs_count
  end

  def update_diet
    return unless species_changed?

    self.diet = Park::Dinosaurs::CARNIVORES.include?(species.to_sym) ? :carnivores.to_s : :herbivores.to_s
  end
end
