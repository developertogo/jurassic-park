# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class DeleteServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :dinosaur, :doorkeeper_application

    def setup
      @cage = create(:cage, power_status: :active, dinosaurs_count: 1)
      @dinosaur = create(:dinosaur, cage: @cage)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should delete dinosaur when not contained (not in a cage) successfully' do
      dinosaur = create(:dinosaur)
      params = { id: dinosaur.id }

      assert_difference 'Dinosaur.count', -1 do
        service = Dinosaurs::DeleteService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should delete dinosaur when contained in a cage successfully' do
      params = { id: dinosaur.id }

      assert_difference 'Dinosaur.count', -1 do
        service = Dinosaurs::DeleteService.new(params:, doorkeeper_application:).call

        assert_equal 1, cage.dinosaurs_count
        cage.reload
        assert_equal 0, cage.dinosaurs_count

        assert service.success?
      end
    end
  end
end
