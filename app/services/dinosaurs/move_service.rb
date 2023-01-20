# frozen_string_literal: true

module Dinosaurs
  class MoveService < ApplicationService
    option :params, type: Types::Hash
    attr_accessor :dinosaur, :cage, :cage_old

    def call
      ActiveRecord::Base.transaction(requires_new: true) do
        dinosaur = Dinosaur.find(params[:id])
        cage_old = dinosaur.cage
        cage_old.dinosaurs.destroy(dinosaur)
        cage = Cage.find(params[:cage_id])
        #binding.pry
        cage.dinosaurs << dinosaur
        dinosaur.cage = cage

        return Success(dinosaur) if dinosaur.save && cage.save

        resource_failure(dinosaur)
        #Failure(dinosaur)
      end
    end
  end
end
