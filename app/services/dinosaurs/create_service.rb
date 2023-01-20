# frozen_string_literal: true

module Dinosaurs
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      dinosaur = yield create_resource(Dinosaur)
      return Success(dinosaur)
    end
  end
end
