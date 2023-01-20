module Park
  module Cage
    POWER_STATUS = %i[active down]
  end

  module Dinosaur
    DIET = %i[carnivores herbivores] # omnivores is another option

    CARNIVORES = %i[tyrannosaurus giganotosaurus velociraptor spinosaurus megalosaurus yutyrannus 
                    acrocanthosaurus carnotaurus deinonychus allosaurus troodon herrerasaurus]
    HERBIVORES = %i[brachiosaurus stegosaurus ankylosaurus triceratops diplodocus dracorex 
                    moschops argentinosaurus edmontosaurus hadrosaurus nodosaurus]
    SPECIES = CARNIVORES + HERBIVORES
  end
end