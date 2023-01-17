# frozen_string_literal: true

module Dinosaurs
  class CreateService < ApplicationService
    option :params, type: Types::Hash

    def call
      ActiveRecord::Base.transaction(requires_new: true) do
        #dinosaur = yield create_resource(Dinosaur)
        cage = Cage.find(params[:cage_id])
        dinosaur = cage.dinosaurs.create(params)
        cage.books << dinosaur

        return Success(dinosaur) if dinosaur.save

        resource_failure(dinosaur)
        #Failure(dinosaur)
      end
    end
  end
end
