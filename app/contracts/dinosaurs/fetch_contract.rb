# frozen_string_literal: true

module Dinosaurs
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
      optional(:query).maybe(:string)
    end

    # NOTE: Work in progress
    # Attemptng to validate query parameter string
    # rule(:query) do
    #   query_hash = convert_to_hash(value) if key?
    #   query_key = query_hash.keys[0] if key?
    #   key.failure("invalid query key") if key? && query_key != :species_eq
    #   return key.failure("invalid query value") if key? && Park::Dinosaurs::SPECIES.exclude?(query_hash.values[0])
    # end
  end
end
