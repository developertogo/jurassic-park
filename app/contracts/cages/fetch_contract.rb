# frozen_string_literal: true

module Cages
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
      optional(:query).value(:string)
    end

    json_id_schema = Dry::Schema.JSON do
      required(:dinosaurs).value(:empty?)
    end

    json_no_id_schema = Dry::Schema.JSON do
      values = Park::Cages::POWER_STATUS.map(&:to_s)
      required(:power_status_eq).filled(included_in?: values)
    end

    rule(:query) do
      if values[:id].present? && values[:query].present?
        result = json_id_schema.call(JSON.parse(value))
        key.failure(result.errors.to_h.inspect) if key? && result.failure?
      elsif values[:query].present?
        result = json_no_id_schema.call(JSON.parse(value))
        key.failure(result.errors.to_h.inspect) if key? && result.failure?
      end
    rescue JSON::ParserError
      key.failure('invalid json format')
    end
  end
end
