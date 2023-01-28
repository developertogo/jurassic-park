# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage, power_status: :active.to_s)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should delete cage successfully' do
      params = { id: cage.id }

      assert_difference 'Cage.count', -1 do
        service = Cages::DeleteService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should not delete cage when it contains dinosaurs' do
      cage = create(:cage, power_status: :active.to_s)
      create(:dinosaur, cage:)
      cage.dinosaurs_count = 1
      cage.save
      params = { id: cage.id }

      assert_no_difference -> { cage.dinosaurs_count } do
        service = Cages::DeleteService.new(params:, doorkeeper_application:).call

        assert service.failure?
        assert_equal "Unable to delete cage #{cage.tag}. It's not empty, it contains #{cage.dinosaurs_count} dinosaurs", service.failure[:errors][0]
      end
    end
  end
end
