# frozen_string_literal: true

module Park
  module Cages
    POWER_STATUS = %i[active down].freeze
  end

  module Dinosaurs
    DIET = %i[carnivores herbivores].freeze  # omnivores is another option

    CARNIVORES = %i[tyrannosaurus giganotosaurus velociraptor spinosaurus megalosaurus yutyrannus
                    acrocanthosaurus carnotaurus deinonychus allosaurus troodon herrerasaurus].freeze
    HERBIVORES = %i[brachiosaurus stegosaurus ankylosaurus triceratops diplodocus dracorex
                    moschops argentinosaurus edmontosaurus hadrosaurus nodosaurus].freeze
    SPECIES = CARNIVORES + HERBIVORES
  end
end
