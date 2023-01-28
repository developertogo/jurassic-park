# frozen_string_literal: true

module Dinosaurs
  class FetchService < ApplicationService
    option :params, type: Types::Hash

    def call
      @qjson = Utils::Json.convert_to_hash params[:query]
      result = params[:id].present? ? fetch_one_dinosaur : fetch_dinosaurs

      Success(result)
    end

    private

    def fetch_one_dinosaur
      Dinosaur.find(params[:id])
    end

    def fetch_dinosaurs
      Dinosaur.ransack(@qjson).result
    end
  end
end
