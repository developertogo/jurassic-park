# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class EditContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::EditContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end
  end
end
