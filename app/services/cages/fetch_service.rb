# frozen_string_literal: true

module Cages
  class FetchService < ApplicationService
    option :params, type: Types::Hash

    def call
      @qjson = Utils::Json.convert_to_hash params[:query]
      result = params[:id].present? ? fetch_one_cage : fetch_cages

      Success(result)
    end

    private

    def fetch_one_cage
      cage = Cage.find(params[:id])

      return cage.dinosaurs if @qjson&.key?(:dinosaurs)

      cage
    end

    def fetch_cages
      Cage.ransack(@qjson).result
    end
  end
end
