# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteOperationTest < ActiveSupport::TestCase
    attr_reader :doorkeeper_application

    def setup
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should pass contract validation then calling the service' do
      params_mock = mock
      params_mock.expects(:to_h).returns(params_mock)

      contract_mock = mock
      Cages::DeleteContract.expects(:new).returns(contract_mock)
      contract_mock.expects(:call).with(params_mock).returns(contract_mock)
      contract_mock.expects(:success?).returns(true)
      contract_mock.expects(:to_h).returns(contract_mock)

      service_mock = mock
      Cages::DeleteService.expects(:new).returns(service_mock)
      service_mock.expects(:call).returns(Dry::Monads::Result::Success.new(true))

      operation = Cages::DeleteOperation.new(params: params_mock, doorkeeper_application:).call

      assert operation.success?
    end

    test 'should return errors if something goes wrong while validating params' do
      service_mock = mock
      Cages::DeleteService.expects(:new).returns(service_mock).never

      operation = Cages::DeleteOperation.new(params: {}, doorkeeper_application:).call

      errors = contract_errors_parser(operation.failure)

      assert operation.failure?
      assert errors.keys.any?
    end

    test 'should return errors if something goes wrong while executing service' do
      params_mock = mock
      params_mock.expects(:to_h).returns(params_mock)

      contract_mock = mock
      Cages::DeleteContract.expects(:new).returns(contract_mock)
      contract_mock.expects(:call).with(params_mock).returns(contract_mock)
      contract_mock.expects(:success?).returns(true)
      contract_mock.expects(:to_h).returns(contract_mock)

      service_mock = mock
      Cages::DeleteService.expects(:new).returns(service_mock)
      service_mock.expects(:call).returns(Dry::Monads::Result::Failure.new(:failed_because_of_me))

      operation = Cages::DeleteOperation.new(params: params_mock, doorkeeper_application:).call

      assert operation.failure?
      assert_equal :failed_because_of_me, operation.failure
    end
  end
end
