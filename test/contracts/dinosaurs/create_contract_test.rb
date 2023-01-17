# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class CreateContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::CreateContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
