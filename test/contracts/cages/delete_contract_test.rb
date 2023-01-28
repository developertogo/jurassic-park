# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::DeleteContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#id' do
      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :id, CONTRACT)
      filled?(validate({ id: nil }), :id, CONTRACT)
      filled?(validate({ id: '' }), :id, CONTRACT)
      uuid_v4?(validate({ id: '1234567890' }), :id, CONTRACT)
    end
  end
end
