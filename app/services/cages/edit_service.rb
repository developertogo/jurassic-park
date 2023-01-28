# frozen_string_literal: true

module Cages
  class EditService < ApplicationService
    option :params, :cage, type: Types::Hash

    def call
      cage = Cage.find(params[:id])

      return Success() if cage.update(params)

      resource_failure(cage)
    end
  end
end
