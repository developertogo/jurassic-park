# frozen_string_literal: true

module Dinosaurs
  class EditService < ApplicationService
    option :params, type: Types::Hash

    def call
      dinosaur = yield fetch_dinosaur
      result = yield update_dinosaur(dinosaur)

      Success(result)
    end

    private

    def fetch_dinosaur
      dinosaur = Dinosaur.find(params[:id])

      Success(dinosaur)
    end

    def update_dinosaur(dinosaur)
      return Success('Dinosaur saved!') if dinosaur.update(params)

      resource_failure(dinosaur)
    end
  end
end
