# frozen_string_literal: true

require 'test_helper'

module Cages
  class CreateContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::CreateContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#tag' do
      success?(validate({ tag: 'C-001' }), :tag, CONTRACT)
      filled?(validate({ tag: nil }), :tag, CONTRACT)
      filled?(validate({ tag: '' }), :tag, CONTRACT)
    end

    test 'validate#power_status' do
      success?(validate({ power_status: Park::Cages::POWER_STATUS[0].to_s.downcase }), :power_status, CONTRACT)
      filled?(validate({ power_status: nil }), :power_status, CONTRACT)
      filled?(validate({ power_status: '' }), :power_status, CONTRACT)
      included_in?(validate({ power_status: 'up' }), :power_status, Park::Cages::POWER_STATUS, CONTRACT)
    end

    test 'validate#max_capacity' do
      success?(validate({ max_capacity: 8 }), :max_capacity, CONTRACT)
      filled?(validate({ max_capacity: nil }), :max_capacity, CONTRACT)
      filled?(validate({ max_capacity: '' }), :max_capacity, CONTRACT)
      gt?(validate({ max_capacity: 0 }), :max_capacity, 0, CONTRACT)
      lteq?(validate({ max_capacity: Cage::MAX_CAPACITY + 1 }), :max_capacity, Cage::MAX_CAPACITY, CONTRACT)
    end

    test 'validate#location' do
      success?(validate({ tag: 'SFO' }), :tag, CONTRACT)
      filled?(validate({ tag: nil }), :tag, CONTRACT)
      filled?(validate({ tag: '' }), :tag, CONTRACT)
    end
  end
end
