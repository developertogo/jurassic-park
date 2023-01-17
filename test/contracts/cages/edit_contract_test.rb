# frozen_string_literal: true

require 'test_helper'

module Cages
  class EditContractTest < ActiveSupport::TestCase
    CONTRACT = Cages::EditContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
