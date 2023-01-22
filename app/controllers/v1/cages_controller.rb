# frozen_string_literal: true

module V1
  class CagesController < ApplicationController
    include Doorkeeper::Authorize

    def index
      fetch
    end

    def show
      fetch
    end

    def create
      operation = ::Cages::CreateOperation.new(params: cage_params,
                                               doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :created
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    def update
      operation = ::Cages::EditOperation.new(params: cage_params,
                                              doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    def destroy
      operation = ::Cages::DeleteOperation.new(params: cage_params,
                                               doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def cage_params
      params.permit(:id, :tag, :power_status, :max_capacity, :location, :query)
    end

    def fetch
      operation = ::Cages::FetchOperation.new(params: cage_params,
                                              doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end
  end
end