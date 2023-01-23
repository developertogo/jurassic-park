# frozen_string_literal: true

module Dinosaurs
  class DeleteService < ApplicationService
    option :params, type: Types::Hash

    def call
      dinosaur = yield fetch_dinosaur
      result = yield delete_dinosaur(dinosaur)

      Success(result)
    end

    private

    def fetch_dinosaur
      dinosaur = Dinosaur.find(params[:id])

      Success(dinosaur)
    end

    def delete_dinosaur(dinosaur)
      return Success('Dinosaur deleted!') if dinosaur.destroy

      resource_failure(dinosaur)
    end
  end
end