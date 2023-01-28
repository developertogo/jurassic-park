# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class MoveServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :dinosaur, :doorkeeper_application

    def setup
      @cage = create(:cage, max_capacity: 1, power_status: :active.to_s)
      @dinosaur = create(:dinosaur, species: :tyrannosaurus.to_s, cage: @cage)
      @cage.dinosaurs_count = 1
      @cage.save
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should move dinosaur successfully' do
      cage_from = dinosaur.cage
      cage_to = create(:cage, max_capacity: 1, power_status: :active.to_s)

      params = { id: dinosaur.id,
                 cage_id: cage_to.id }
      assert_changes -> { dinosaur.cage } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload
        cage_from.reload
        cage_to.reload

        assert service.success?
        assert_equal 0, cage_from.dinosaurs_count, 'Cage (from) dinosaurs count should be 0'
        assert_equal 1, cage_to.dinosaurs_count, 'Cage (to) dinosaur count should be 1'
      end
    end

    test 'should not move a dinosaur to the same cage that it is already contained' do
      cage = create(:cage, max_capacity: 2, power_status: :active.to_s)
      dinosaur = create(:dinosaur, species: :stegosaurus.to_s, cage:)
      cage[:dinosaurs_count] = 1
      cage.save

      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_no_difference -> { cage.dinosaurs_count } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload
        cage.reload

        assert service.failure?
        assert_equal "Dinosaur #{dinosaur.name} is already contained in cage #{cage.tag}", service.failure[:errors][0]
      end
    end

    test 'should not move dinosaur if cage has reached max capacity' do
      dinosaur = create(:dinosaur)

      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_no_difference -> { cage.dinosaurs_count } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        cage.reload

        assert service.failure?
        assert_equal "Unable to move to cage #{cage.tag}. It's full (max capacity is #{cage.max_capacity})", service.failure[:errors][0]
      end
    end

    test 'should not move dinosaur if cage power status is `down`' do
      cage = create(:cage, max_capacity: 1, power_status: :down.to_s)

      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_no_difference -> { cage.dinosaurs_count } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload
        cage.reload

        assert service.failure?
        assert_equal "Unable to move to cage #{cage.tag}. It's power status is down", service.failure[:errors][0]
      end
    end

    test 'should not move a dinosaur to a cage containing dinosaurs of a diffrent species' do
      cage = create(:cage, max_capacity: 2, power_status: :active.to_s)
      create(:dinosaur, species: :stegosaurus.to_s, cage:)
      cage[:dinosaurs_count] = 1
      cage.save

      params = { id: dinosaur.id,
                 cage_id: cage.id }
      assert_no_difference -> { cage.dinosaurs_count } do
        service = Dinosaurs::MoveService.new(params:, doorkeeper_application:).call

        dinosaur.reload
        cage.reload

        assert service.failure?
        assert_equal "Unable to move to cage #{cage.tag}. It contains #{cage.dinosaurs[0].diet}, a different species", service.failure[:errors][0]
      end
    end
  end
end
