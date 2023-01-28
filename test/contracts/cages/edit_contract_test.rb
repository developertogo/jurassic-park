# frozen_string_literal: true

require 'test_helper'

module Cages
  class EditContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::EditContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#id' do
      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :id, CONTRACT)
      filled?(validate({ id: nil }), :id, CONTRACT)
      filled?(validate({ id: '' }), :id, CONTRACT)
      uuid_v4?(validate({ id: '1234567890' }), :id, CONTRACT)
    end

    test 'validate#tag' do
      success?(validate({ tag: 'T Rex' }), :tag, CONTRACT)
    end

    test 'validate#power_status' do
      success?(validate({ power_status: Park::Cages::POWER_STATUS[0].to_s.downcase }), :power_status, CONTRACT)
      included_in?(validate({ power_status: 'up' }), :power_status, Park::Cages::POWER_STATUS, CONTRACT)
    end

    test 'validate#location' do
      success?(validate({ tag: 'SFO' }), :tag, CONTRACT)
    end
  end
end
