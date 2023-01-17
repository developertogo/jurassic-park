# frozen_string_literal: true

module Cages
  class EditService < ApplicationService
    option :params, type: Types::Hash

    def call
      cage = yield fetch_cage
      result = yield update_cage(cage)

      Success(result)
    end

    private

    def fetch_cage
      cage = Cage.find(params[:id])

      Success(cage)
    end

    def update_cage(cage)
      return Success('Cage saved!') if cage.update(params)

      resource_failure(cage)
    end
  end
end
