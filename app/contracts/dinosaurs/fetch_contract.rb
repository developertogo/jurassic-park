# frozen_string_literal: true

module Dinosaurs
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
      optional(:query).maybe(:string)
    end

    json_schema = Dry::Schema.JSON do
      values = Park::Dinosaurs::SPECIES.map(&:to_s)
      required(:species_eq).filled(included_in?: values)
    end

    rule(:query) do
      if value.present?
        result = json_schema.call(JSON.parse(value))
        key.failure(result.errors.to_h.inspect) if key? && result.failure?
      end
    end
  end
end
