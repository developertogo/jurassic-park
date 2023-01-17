# frozen_string_literal: true

require 'test_helper'

module Cages
  class FetchContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::FetchContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
