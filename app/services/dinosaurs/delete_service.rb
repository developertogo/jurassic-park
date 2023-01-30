# frozen_string_literal: true

module Dinosaurs
  class DeleteService < ApplicationService
    option :params, :dinosaur, type: Types::Hash

    def call
      dinosaur = Dinosaur.find(params[:id])

      begin
        ActiveRecord::Base.transaction(requires_new: true) do
          cage = dinosaur.cage
          if cage.present?
            cage.dinosaurs&.delete(dinosaur)
            return resource_failure(cage) unless cage.save
          end

          dinosaur.destroy

          Success()
        end
      rescue StandardError
        resource_failure(dinosaur)
      end
    end
  end
end
