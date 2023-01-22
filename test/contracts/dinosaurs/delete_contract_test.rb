# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class DeleteContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::DeleteContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
