# frozen_string_literal: true

module Dinosaurs
  class MoveService < ApplicationService
    option :params, type: Types::Hash
    attr_reader :dinosaur, :cage, :cage_old

    def call
      new_cage = Cage.find(params[:cage_id])
      dinosaur = Dinosaur.find(params[:id])
      old_cage = dinosaur.cage

      ActiveRecord::Base.transaction(requires_new: true) do
        new_cage.dinosaurs << dinosaur
        new_cage.save
        dinosaur.cage = new_cage
        dinosaur.save
        old_cage.dinosaurs.delete(dinosaur)
        old_cage.save
      end

      Success(dinosaur)
    rescue StandardError
      resource_failure(new_cage)
    end
  end
end
