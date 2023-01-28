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

    # test 'validate#query' do
    #   success?(validate({ query: '{"species_eq": "tyrannosaurus"}' }), :query, CONTRACT)
    #   # type?(validate({ query: '{"speciestest_eq": "tyrannosaurus"}' }), :query, string, CONTRACT)
    #   # type?(validate({ query: '{"species_eq": "test"}' }), :query, string, CONTRACT)
    # end
  end
end
