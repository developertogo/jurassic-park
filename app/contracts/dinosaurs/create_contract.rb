# frozen_string_literal: true

# require './app/lib/park'

module Dinosaurs
  class CreateContract < ApplicationContract
    params do
      values = Park::Dinosaurs::SPECIES.map { |s| s.to_s.downcase }
      # NOTE: Attempted to check uniqueness before reaching to the DB with no success,
      # see work in branch: https://github.com/developertogo/jurassic-park/tree/uniqueness-enum-validation
      required(:name) { filled? & str? }
      required(:species).filled(Types::String.enum(*values))
      required(:cage_id) { filled? & uuid_v4? }
    end
  end
end
