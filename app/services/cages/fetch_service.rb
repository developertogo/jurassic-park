# frozen_string_literal: true

module Cages
  class FetchService < ApplicationService
    option :params, type: Types::Hash

    def call
      if params[:id].present?
        result = yield fetch_one_cage
      else
        result = yield fetch_cages
      end

      Success(result)
    end

    private

    def fetch_one_cage
      cage = Cage.find(params[:id])

      if params[:query]&.has_key?(:dinosaurs)
        return Success(cage.dinosaurs)
      end

      Success(cage)
    end

    def fetch_cages
      cages = Cage.ransack(params[:query]).result

      Success(cages)
    end
  end
end
