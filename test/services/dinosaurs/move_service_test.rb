# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class MoveServiceTest < ActiveSupport::TestCase
    attr_reader :params, :dinosaur, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should move dinosaur successfully' do
      cage_from = dinosaur.cage
      cage_to = create(:cage, max_capacity: 1, power_status: Park::Cages::POWER_STATUS[0].to_s)

      params = { id: dinosaur.id,
                 cage_id: cage_to.id }
      assert_changes -> { dinosaur.cage } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload
        cage_from.reload
        cage_to.reload

        assert service.success?
        assert_equal 0, cage_from.dinosaurs_count, "Cage (from) dinosaurs count should be 0"
        assert_equal 1, cage_to.dinosaurs_count, "Cage (to) dinosaur count should be 1"
      end
    end

    test 'should not move dinosaur if cage has reached max capacity' do
      cage = create(:cage, max_capacity: 1, power_status: Park::Cages::POWER_STATUS[0].to_s)
      dinosaur_2 = create(:dinosaur, cage: cage)

      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_no_difference -> { cage.dinosaurs_count } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        cage.reload

        #binding.pry
        assert service.failure?
        assert_equal "Unable to move to cage #{cage.tag}. It's full (max capacity is #{cage.max_capacity})", service.failure[:errors][0] 
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
