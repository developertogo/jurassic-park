module V1
  module Dinosaurs
    class DinosaursController < ApplicationController
      include Doorkeeper::Authorize

      #before_action :set_dinosaur, only: %i[ show update destroy ]

      def fetch 
        operation = ::Dinosaurs::FetchOperation.new(params: dinosaur_params,
                                                    doorkeeper_application: current_doorkeeper_application).call
        if operation.success?
          render json: operation.success, status: :ok
        else
          render json: operation.failure, status: :unprocessable_entity
        end
      end

      def create
        operation = ::Dinosaurs::CreateOperation.new(params: dinosaur_params,
                                                     doorkeeper_application: current_doorkeeper_application).call
        if operation.success?
          render json: operation.success, status: :created
        else
          render json: operation.failure, status: :unprocessable_entity
        end
        # move to service
        # @dinosaur = Dinosaur.new(dinosaur_params)

        # if @dinosaur.save
        #   render :show, status: :created, location: @dinosaur
        # else
        #   render json: @dinosaur.errors, status: :unprocessable_entity
        # end
      end

      def update
        operation = ::Dinosaurs::EditOperation.new(params: dinosaur_params,
                                                   doorkeeper_application: current_doorkeeper_application).call
        if operation.success?
          render json: operation.success, status: :ok
        else
          render json: operation.failure, status: :unprocessable_entity
        end
        # if @dinosaur.update(dinosaur_params)
        #   render :show, status: :ok, location: @dinosaur
        # else
        #   render json: @dinosaur.errors, status: :unprocessable_entity
        # end
      end

      # def destroy
      #   operation = ::Dinosaurs::DeleteOperation.new(params: dinosaur_params,
      #                                                doorkeeper_application: current_doorkeeper_application).call
      #   if operation.success?
      #     render json: operation.success, status: :ok
      #   else
      #     render json: operation.failure, status: :unprocessable_entity
      #   end
      #   @dinosaur.destroy
      # end

      private

      # Only allow a list of trusted parameters through.
      def dinosaur_params
        params.require(:dinosaur).permit(:name, :species, :cage_id)
      end
    end
  end
end
