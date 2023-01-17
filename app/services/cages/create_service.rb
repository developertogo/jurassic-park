# frozen_string_literal: true

module Cages
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      cage = yield create_resource(Cage)
      # cage = Cage.new(params)

      return Success(cage) if cage.save

      resource_failure(cage)
      #Failure(cage)
    end
  end
end
