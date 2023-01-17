# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class MoveContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::MoveContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
