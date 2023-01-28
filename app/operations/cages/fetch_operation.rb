# frozen_string_literal: true

module Cages
  class FetchOperation < ApplicationOperation
    option :params
    option :doorkeeper_application, type: Types.Instance(Doorkeeper::Application)
    option :contract, default: proc { Cages::FetchContract.new }

    def call
      contract_params = yield validate(contract)
      result = yield call_service(contract_params)

      Success(result)
    end

    private

    def call_service(contract_params)
      Cages::FetchService.new(params: contract_params, doorkeeper_application:).call
    end
  end
end
