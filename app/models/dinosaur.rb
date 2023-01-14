class Dinosaur < ApplicationRecord
  include ValidatableEnum

  belongs_to :cage

  attr_reader :diet

  after_update :update_diet
  before_save :update_diet

  DIET = %i[herbivores carnivores] # omnivores is another option 
  enum diet: DIET

  CARNIVORES = %i[tyrannosaurus giganotosaurus velociraptor spinosaurus megalosaurus yutyrannus 
                  acrocanthosaurus carnotaurus deinonychus allosaurus troodon herrerasaurus]
  HERBIVORES = %i[brachiosaurus stegosaurus ankylosaurus triceratops diplodocus dracorex 
                  moschops argentinosaurus edmontosaurus hadrosaurus nodosaurus]
  SPECIES = CARNIVORES + HERBIVORES
  enum species: SPECIES

  validates :name, presence: true, uniqueness: true, allow_blank: false
  validates :species, inclusion: { in: SPECIES.keys,
                                   message: "species must be one of #{SPECIES.keys}" }
  validatable_enum :species

  private

  def update_diet
    return unless species_changed?
    diet = species in CARNIVORES ? :carnivores : :herbivores
  end
end
