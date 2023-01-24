# frozen_string_literal: true

require './app/lib/park'

class Dinosaur < ApplicationRecord
  # NOTE: tried to use counter_cache but cage.dinosaurs_count becomes -1
  # attempting to move a dinosaur from the "from" cage containing just this dinosaur.
  # Expected the count to be 0, but not -1; even from_cage.dinosaurs.size returns -1
  # belongs_to :cage #, counter_cache: true
  belongs_to :cage

  attr_reader :diet

  before_save :update_diet

  # Workaround: using this callback to update cage.dinosaurs_count 'cause read line 6 above
  after_save :update_dinosaurs_count

  enum :diet, Park::Dinosaurs::DIET.zip(Park::Dinosaurs::DIET.map(&:to_s)).to_h, scopes: false
  enum :species, Park::Dinosaurs::SPECIES.zip(Park::Dinosaurs::SPECIES.map(&:to_s)).to_h, scopes: false

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :species, inclusion: { in: Park::Dinosaurs::SPECIES.map(&:to_s),
                                   message: 'Invalid species' }

  # Commented this line because of the error below on Rails 7.0.4
  # validatable_enum :species

  # I was trying to override the error message if enum was invalid by following this blog:
  #   ActiveRecord::Enum validation in Rails API, https://medium.com/nerd-for-tech/using-activerecord-enum-in-rails-35edc2e9070f

  # Rails issue #44842:
  #   Enum conflict error message is misleading, https://github.com/rails/rails/issues/44842

  # This was the error message:
  #   /Users/chung/.rvm/gems/ruby-3.1.2/gems/activerecord-7.0.4/lib/active_record/enum.rb:301:in `raise_conflict_error':
  #   You tried to define an enum named "diet" on the model "Dinosaur", but this will generate a instance method "herbivores_diet?",
  #   which is already defined by another enum. (ArgumentError)

  # By just doing the following:
  #   > rails c
  #   > Dinosaur.first

  private

  def update_dinosaurs_count
    cage.update_dinosaurs_count
  end

  def update_diet
    return unless species_changed?

    self.diet = (species in Park::Dinosaurs::CARNIVORES) ? :carnivores : :herbivores
  end
end
