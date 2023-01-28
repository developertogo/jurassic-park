# frozen_string_literal: true

FactoryBot.define do
  max_capacity = Faker::Number.between(from: 1, to: 100)
  factory :cage do
    tag { "C-#{Faker::Number.unique.leading_zero_number(digits: 3)}" }
    power_status { Park::Cages::POWER_STATUS[Faker::Number.between(from: 0, to: 1)].to_s }
    dinosaurs_count { 0 }
    max_capacity { max_capacity }
    location { Faker::Lorem.words(number: 1)[0] }
  end
end
