# frozen_string_literal: true

def carnivores_idx
  Faker::Number.between(from: 0, to: Park::Dinosaurs::CARNIVORES.length - 1)
end

def herbivores_idx
  Faker::Number.between(from: Park::Dinosaurs::CARNIVORES.length, to: Park::Dinosaurs::SPECIES.length - 1)
end

FactoryBot.define do
  diet_idx = Faker::Number.between(from: 0, to: 1)
  species_idx = diet_idx.zero? ? carnivores_idx : herbivores_idx

  factory :dinosaur do
    association :cage, strategy: :null # , power_status: :active, dinosaurs_count: 1
    name { Faker::Name.unique.name }
    diet { Park::Dinosaurs::DIET[diet_idx].to_s }
    species { Park::Dinosaurs::SPECIES[species_idx].to_s }
  end
end
