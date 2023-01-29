# frozen_string_literal: true

# require './app/lib/park'

module Cages
  class CreateContract < ApplicationContract
    params do
      values = Park::Cages::POWER_STATUS.map(&:to_s)
      # NOTE: Attempted to check uniqueness before reaching to the DB with no success,
      # see work in branch: https://github.com/developertogo/jurassic-park/tree/uniqueness-enum-validation
      required(:tag) { filled? & str? }
      required(:power_status).filled(included_in?: values)
      # another alternative
      # required(:power_status).filled(Types::String.enum(*values))
      required(:max_capacity).filled(:int?, gt?: 0, lteq?: Park::Cages::MAX_CAPACITY)
      required(:location).filled(:string)
    end

    rule(:max_capacity) do
      key.failure("the max capacity is #{Park::Cages::MAX_CAPACITY}") if value > Park::Cages::MAX_CAPACITY
    end
  end
end
