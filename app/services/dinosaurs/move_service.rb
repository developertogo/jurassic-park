# frozen_string_literal: true

module Dinosaurs
  class MoveService < ApplicationService
    option :params, type: Types::Hash

    def call
      ActiveRecord::Base.transaction(requires_new: true) do
        #dinosaur = yield create_resource(Dinosaur)
        dinosaur = Dinosaur.find(params[:id])
        cage_old = dinosaur.cage
        cage_old.dinosaurs.destroy(dinosaur)
        cage = Cage.find(params[:cage_id])
        cage.books << dinosaur
        dinosaur.cage = cage

        return Success(dinosaur) if dinosaur.save && cage.save

        resource_failure(dinosaur)
        #Failure(dinosaur)
      end
    end
  end
end
