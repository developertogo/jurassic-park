# frozen_string_literal: true

# require './app/lib/park'

class Dinosaur < ApplicationRecord
  # NOTE: Could not use counter_cache, need association callbacks to be fired
  belongs_to :cage, optional: true

  before_save :update_diet

  enum :diet, Park::Dinosaurs::DIET.zip(Park::Dinosaurs::DIET.map(&:to_s)).to_h, scopes: false
  enum :species, Park::Dinosaurs::SPECIES.zip(Park::Dinosaurs::SPECIES.map(&:to_s)).to_h, scopes: false

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :species, inclusion: { in: Park::Dinosaurs::SPECIES.map(&:to_s),
                                   message: 'Invalid species' }

  private

  def update_diet
    return unless species_changed?

    self.diet = Park::Dinosaurs::CARNIVORES.include?(species.to_sym) ? :carnivores.to_s : :herbivores.to_s
  end
end
