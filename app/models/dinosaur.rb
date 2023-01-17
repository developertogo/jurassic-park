require './app/lib/park.rb'

class Dinosaur < ApplicationRecord
  include ValidatableEnum

  belongs_to :cage

  attr_reader :diet

  after_update :update_diet
  before_save :update_diet

  enum :diet, Park::Dinosaur::DIET, scopes: false
  enum :species, Park::Dinosaur::SPECIES, scopes: false

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :species, inclusion: { in: Park::Dinosaur::SPECIES,
                                   message: "Invalid species" }

  # Commented this line because of the error below on Rails 7.0.4
  #validatable_enum :species

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

  def update_diet
    return unless species_changed?
    diet = (species in Park::Dinosaur::CARNIVORES) ? :carnivores : :herbivores
  end
end
