# frozen_string_literal: true

FactoryBot.define do
  diet_idx = Faker::Number.between(from: 0, to: 1)
  if diet_idx == 0
    species_idx = Faker::Number.between(from: 0, 
                                        to: Park::Dinosaur::CARNIVORES.length-1) 
  else
    species_idx = Faker::Number.between(from: Park::Dinosaur::CARNIVORES.length, 
                                        to: Park::Dinosaur::SPECIES.length-1) 
  end
  factory :dinosaur do
    association :cage
    name { Faker::Name.unique.name }
    diet { Park::Dinosaur::DIET[diet_idx].to_s }
    species { Park::Dinosaur::SPECIES[species_idx].to_s }
  end
end
