# frozen_string_literal: true

require 'test_helper'

module Cages
  class CreateServiceTest < ActiveSupport::TestCase
    attr_reader :params, :doorkeeper_application

    def setup
      @params = attributes_for(:cage)
    end

    test 'should create cage' do
      assert_difference 'Cage.count', 1 do
        service = Cages::CreateService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should fail if something goes wrong' do
      Cage.any_instance.expects(:save).returns(false)

      assert_no_difference 'Cage.count' do
        service = Cages::CreateService.new(params:, doorkeeper_application:).call

        assert service.failure?
      end
    end
  end
end
