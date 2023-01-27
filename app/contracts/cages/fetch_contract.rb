# frozen_string_literal: true

module Cages
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
      optional(:query).value(:string)
    end

    # NOTE: Work in progress
    # Attemptng to validate query parameter string
    # rule(:query) do
    #   query_hash = convert_to_hash(value) if key?
    #   query_key = query_hash.keys[0] if key?
    #   # NOTE
    #   # Getting `LocalJumpError: unexpected return`
    #   # return key.failure("invalid query key") if key? && [:power_status_eq, :dinosaurs].exclude?(query_key)
    #   return key.failure("invalid query value") if key? && Park::Cages::POWER_STATUS.exclude?(query_hash.values[0].to_sym)
    # end
  end
end
