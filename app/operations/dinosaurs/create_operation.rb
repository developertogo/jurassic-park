# frozen_string_literal: true

module Dinosaurs
  class CreateOperation < ApplicationOperation
    option :params
    option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
    option :contract, default: proc { Dinosaurs::CreateContract.new }

    def call
      contract_params = yield validate(contract)
      result = yield call_service(contract_params)

      Success(result)
    end

    private

    def call_service(contract_params)
      Dinosaurs::CreateService.new(params: contract_params, doorkeeper_application:).call
    end
  end
end
