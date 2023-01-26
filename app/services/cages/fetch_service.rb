# frozen_string_literal: true

module Cages
  class FetchService < ApplicationService
    option :params, type: Types::Hash

    def call
      result = yield params[:id].present? ? fetch_one_cage : fetch_cages
      Success(result)
    end

    private

    def fetch_one_cage
      cage = Cage.find(params[:id])

      return Success(cage.dinosaurs) if params[:query]&.key?(:dinosaurs)

      Success(cage)
    end

    def fetch_cages
      cages = Cage.ransack(params[:query]).result

      Success(cages)
    end
  end
end
