# frozen_string_literal: true

module Cages
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      cage = yield create_resource(Cage)
      Success(cage)
    end
  end
end
