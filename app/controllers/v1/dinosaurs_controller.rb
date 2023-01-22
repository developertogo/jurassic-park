# frozen_string_literal: true

module V1
  class DinosaursController < ApplicationController
    include Doorkeeper::Authorize

    def index
      fetch
    end

    def show
      fetch
    end

    def create
      operation = ::Dinosaurs::CreateOperation.new(params: dinosaur_params,
                                                   doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :created
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    def move
      operation = ::Dinosaurs::MoveOperation.new(params: dinosaur_params,
                                                 doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    def update
      operation = ::Dinosaurs::EditOperation.new(params: dinosaur_params,
                                                  doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    def destroy
      operation = ::Dinosaurs::DeleteOperation.new(params: dinosaur_params,
                                                   doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end

    private

    # Only allow a list of trusted parameters through.
    def dinosaur_params
      params.permit(:id, :name, :species, :cage_id)
    end

    def fetch 
      operation = ::Dinosaurs::FetchOperation.new(params: dinosaur_params,
                                                  doorkeeper_application: current_doorkeeper_application).call
      if operation.success?
        render json: operation.success, status: :ok
      else
        render json: operation.failure, status: :unprocessable_entity
      end
    end
  end
end
