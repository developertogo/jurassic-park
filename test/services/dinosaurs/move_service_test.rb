# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class MoveServiceTest < ActiveSupport::TestCase
    attr_reader :params, :doorkeeper_application
    attr_accessor :dinosaur

    def setup
      @dinosaur = create(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should move dinosaur successfully' do
      cage = create(:cage)
      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_changes -> { dinosaur.updated_at } do
        #binding.pry
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload

        assert service.success?
      end
    end

    # test 'should ...' do
    #   assert_no_changes -> { something } do
    #     service = Dinosaurs::MoveService.new(params:, , doorkeeper_application:).call

    #     assert service.failure?
    #   end
    # end
  end
end
