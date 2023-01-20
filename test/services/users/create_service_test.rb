# frozen_string_literal: true

require 'test_helper'

module Users
  class CreateServiceTest < ActiveSupport::TestCase
    attr_reader :params, :doorkeeper_application

    def setup
      @params = attributes_for(:user)
    end

    test 'should create user' do
      assert_difference 'User.count', 1 do
        service = Users::CreateService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should fail if something goes wrong' do
      User.any_instance.expects(:save).returns(false)

      assert_no_difference 'User.count' do
        service = Users::CreateService.new(params:, doorkeeper_application:).call

        assert service.failure?
      end
    end
  end
end
