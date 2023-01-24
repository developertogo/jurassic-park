# frozen_string_literal: true

module Cages
  class DeleteService < ApplicationService
    option :params, type: Types::Hash

    def call
      cage = yield fetch_cage
      result = yield delete_cage(cage)

      Success(result)
    end

    private

    def fetch_cage
      cage = Cage.find(params[:id])

      Success(cage)
    end

    def delete_cage(cage)
      cage.destroy

      return Success('Cage deleted!')

    rescue Exception => ex
      resource_failure(cage)
    end
  end
end
