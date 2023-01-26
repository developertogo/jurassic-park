# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage, power_status: :active)
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
      create(:dinosaur, cage:)
      params = { id: cage.id }

      assert_no_difference -> { cage.dinosaurs_count } do
        service = Cages::DeleteService.new(params:, doorkeeper_application:).call

        assert service.failure?
        assert_equal "Unable to delete cage #{cage.tag}. It's not empty, it contains #{cage.dinosaurs_count} dinosaurs", service.failure[:errors][0]
      end
    end
  end
end
