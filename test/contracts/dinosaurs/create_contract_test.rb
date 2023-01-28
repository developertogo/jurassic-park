# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class CreateContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::CreateContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#name' do
      success?(validate({ name: 'T Rex' }), :name, CONTRACT)
      filled?(validate({ name: nil }), :name, CONTRACT)
      filled?(validate({ name: '' }), :name, CONTRACT)
    end

    test 'validate#species' do
      success?(validate({ species: Park::Dinosaurs::SPECIES[0].to_s.downcase }), :species, CONTRACT)
      filled?(validate({ species: nil }), :species, CONTRACT)
      filled?(validate({ species: '' }), :species, CONTRACT)
      included_in?(validate({ species: 'dog' }), :species, Park::Dinosaurs::SPECIES, CONTRACT)
    end
  end
end
