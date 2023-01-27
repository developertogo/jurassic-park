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

    # test 'validate#query' do
    #   success?(validate({ query: '{"power_status_eq": "active"}' }), :query, CONTRACT)
    #   filled?(validate({ query: '{"power_status": "down"}' }), :query, CONTRACT)
    #   filled?(validate({ query: '{"power_status_eq": "up"}' }), :query, CONTRACT)

    #   success?(validate({ query: '{"dinosaurs": ""}' }), :query, CONTRACT)
    #   success?(validate({ query: '{"dinosaurs": "all"}' }), :query, CONTRACT)
    #   filled?(validate({ query: '{"dinosaur": ""}' }), :query, CONTRACT)
    # end
  end
end
