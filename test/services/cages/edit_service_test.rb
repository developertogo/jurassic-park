# frozen_string_literal: true

require 'test_helper'

module Cages
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage)
      @params = attributes_for(:cage)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should update cage successfully' do
      params[:id] = cage.id

      assert_changes -> { cage.updated_at } do
        service = Cages::EditService.new(params:, doorkeeper_application:).call

        cage.reload

        assert service.success?
        assert_equal 'Cage saved!', service.success
      end
    end

    test 'should not allow to power `down` if it contains dinosaurs' do
      params = { id: cage.id,
                 power_status: :down }
      cage[:power_status] = :active
      cage[:dinosaurs_count] = 1
      dinosaur = create(:dinosaur, cage: cage)

      assert_no_changes -> { cage.dinosaurs_count } do
        service = Cages::EditService.new(params:, doorkeeper_application:).call

        cage.reload

        assert service.failure?
        assert_equal "Unable to power off cage #{cage.tag}. It's not empty, it contains #{cage.dinosaurs_count} dinosaurs", service.failure[:errors][0] 
      end
    end
  end
end