# frozen_string_literal: true

module Dinosaurs
  class FetchService < ApplicationService
    option :params, type: Types::Hash

    def call
      if params[:id].present?
        result = yield fetch_one_dinosaur
      else
        result = yield fetch_dinosaurs
      end

      Success(result)
    end

    private

    def fetch_one_dinosaur
      dinosaur = Dinosaur.find(params[:id])

      Success(dinosaur)
    end

    def fetch_dinosaurs
      dinosaurs = Dinosaur.all

      Success(dinosaurs)
    end
  end
end
