# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::DeleteContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
