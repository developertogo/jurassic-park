# frozen_string_literal: true

module Dinosaurs
  class EditService < ApplicationService
    option :params, type: Types::Hash

    def call
      dinosaur = Dinosaur.find(params[:id])
      return Success() if dinosaur.update(params)

      resource_failure(dinosaur)
    end
  end
end
