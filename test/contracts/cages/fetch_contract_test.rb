# frozen_string_literal: true

require 'test_helper'

module Cages
  class FetchContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::FetchContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#id' do
      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :id, CONTRACT)
      uuid_v4?(validate({ id: '1234567890' }), :id, CONTRACT)
    end

    test 'validate#query' do
      values = Park::Cages::POWER_STATUS.map(&:to_s).join(', ').delete('"')
      success?(validate({ query: '{"power_status_eq": "active"}' }), :query, CONTRACT)
      invalid_with?(validate({ query: '{"power_status_eq": "any"}' }), :query, "{:power_status_eq=>[\"must be one of: #{values}\"]}", CONTRACT)
      invalid_with?(validate({ query: '{"somethind_else": "any"}' }), :query, '{:power_status_eq=>["is missing"]}', CONTRACT)
      invalid_with?(validate({ query: 'something = 1' }), :query, 'invalid json format', CONTRACT)

      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2', query: '{"dinosaurs": ""}' }), :query, CONTRACT)
      str?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2', query: nil }), :query, CONTRACT)
      filled_optional?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2', query: '' }), :query, CONTRACT)
      invalid_with?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2', query: '{"dinosaurs": "all"}' }), :query, '{:dinosaurs=>["must be empty"]}', CONTRACT)
      invalid_with?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2', query: '{"dinosaur": "all"}' }), :query, '{:dinosaurs=>["is missing"]}', CONTRACT)
    end
  end
end
