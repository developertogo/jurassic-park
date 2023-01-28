# frozen_string_literal: true

module Cages
  class DeleteService < ApplicationService
    option :params, :cage, type: Types::Hash

    def call
      cage = Cage.find(params[:id])
      cage.destroy

      Success()
    rescue StandardError
      resource_failure(cage)
    end
  end
end
