# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class FetchContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::FetchContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
