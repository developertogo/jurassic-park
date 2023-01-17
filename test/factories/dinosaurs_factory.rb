# frozen_string_literal: true

FactoryBot.define do
  factory :dinosaur do
    association :cage
    name { Faker::Name.unique.name }
    diet { Park::Dinosaur::DIET[Faker::Number.between(from: 0, to: 1)] }
    species { Park::Dinosaur::SPECIES[Faker::Number.between(from: 0, to: Park::Dinosaur::SPECIES.length-1)] }
  end
end
