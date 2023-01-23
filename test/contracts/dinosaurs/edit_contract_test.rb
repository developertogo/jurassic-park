# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class EditContractTest < ActiveSupport::TestCase
    CONTRACT = Dinosaurs::EditContract.new

    def validate(payload = {})
      CONTRACT.call(payload)
    end

    test 'validate#id' do
      success?(validate({ id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :id, CONTRACT)
      filled?(validate({ id: nil }), :id, CONTRACT)
      filled?(validate({ id: '' }), :id, CONTRACT)
      uuid_v4?(validate({ id: '1234567890' }), :id, CONTRACT)
    end

    test 'validate#name' do
      success?(validate({ tag: 'Raptor' }), :name, CONTRACT)
    end

    test 'validate#species' do
      success?(validate({ species: Park::Dinosaurs::SPECIES[0].to_s.downcase }), :species, CONTRACT)
      included_in?(validate({ species: 'up' }), :species, Park::Dinosaurs::SPECIES, CONTRACT)
    end

    test 'validate#cage_id' do
      success?(validate({ cage_id: 'dae75e6c-d8b7-4d6f-8434-faa300f00ff2' }), :cage_id, CONTRACT)
      uuid_v4?(validate({ cage_id: '1234567890' }), :cage_id, CONTRACT)
    end
  end
end
