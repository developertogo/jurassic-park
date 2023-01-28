# frozen_string_literal: true

module Dinosaurs
  class MoveService < ApplicationService
    option :params, type: Types::Hash
    attr_reader :dinosaur, :new_cage, :old_cage

    def call
      new_cage = Cage.find(params[:cage_id])
      dinosaur = Dinosaur.find(params[:id])
      old_cage = dinosaur.cage

      # disallow moving to the same cage that dinosaur is already in
      if old_cage == new_cage
        new_cage.errors.add(:base, "Dinosaur #{dinosaur.name} is already contained in cage #{new_cage.tag}")
        return resource_failure(new_cage)
      end

      ActiveRecord::Base.transaction(requires_new: true) do
        if old_cage.present?
          old_cage.dinosaurs&.delete(dinosaur)
          return resource_failure(old_cage) unless old_cage.save
        end

        dinosaur.cage = new_cage
        return resource_failure(dinosaur) unless dinosaur.save

        new_cage.dinosaurs << dinosaur
        return resource_failure(new_cage) unless new_cage.save
      end

      Success(dinosaur)
    rescue StandardError
      resource_failure(new_cage)
    end
  end
end
