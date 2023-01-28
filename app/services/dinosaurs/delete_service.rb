# frozen_string_literal: true

module Dinosaurs
  class DeleteService < ApplicationService
    option :params, :dinosaur, type: Types::Hash

    def call
      dinosaur = Dinosaur.find(params[:id])
      dinosaur.destroy

      Success()
    rescue StandardError
      resource_failure(dinosaur)
    end
  end
end
