# frozen_string_literal: true

module Dinosaurs
  class MoveService < ApplicationService
    option :params, type: Types::Hash
    attr_accessor :dinosaur, :cage, :cage_old

    def call
      new_cage = Cage.find(params[:cage_id])
      dinosaur = Dinosaur.find(params[:id])
      old_cage = dinosaur.cage

      ActiveRecord::Base.transaction(requires_new: true) do
        old_cage.dinosaurs.delete(dinosaur)
        old_cage.save
        dinosaur.cage = new_cage
        dinosaur.save
      end

      new_cage.dinosaurs << dinosaur

      return Success(dinosaur) if new_cage.save

    rescue Exception => ex
      resource_failure(dinosaur)
    end
  end
end
