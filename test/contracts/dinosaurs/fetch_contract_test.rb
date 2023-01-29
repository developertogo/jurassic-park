# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class FetchContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::FetchContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#id' do
      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :id, CONTRACT)
      uuid_v4?(validate({ id: '1234567890' }), :id, CONTRACT)
    end

    test 'validate#query' do
      values = Park::Dinosaurs::SPECIES.map(&:to_s).join(', ').delete('"')
      success?(validate({ query: '{"species_eq": "tyrannosaurus"}' }), :query, CONTRACT)
      invalid_with?(validate({ query: '{"species_eq": "any"}' }), :query, "{:species_eq=>[\"must be one of: #{values}\"]}", CONTRACT)
      invalid_with?(validate({ query: '{"somethind_else": "any"}' }), :query, '{:species_eq=>["is missing"]}', CONTRACT)
    end
  end
end
