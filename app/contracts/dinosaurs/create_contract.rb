# frozen_string_literal: true

# require './app/lib/park'

module Dinosaurs
  class CreateContract < ApplicationContract
    params do
      values = Park::Dinosaurs::SPECIES.map(&:to_s)
      # NOTE: Attempted to check uniqueness before reaching to the DB with no success,
      # see work in branch: https://github.com/developertogo/jurassic-park/tree/uniqueness-enum-validation
      required(:name) { filled? & str? }
      required(:species).filled(Types::String.enum(*values))
      optional(:cage_id) { filled? & uuid_v4? }
    end

    rule(:cage_id) do
      key.failure('updating cage_id is prohibited, use move API instead') if value.present?
    end
  end
end
