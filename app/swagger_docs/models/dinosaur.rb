# frozen_string_literal: true

# require './app/lib/park'

module Models
  class Dinosaur < ApplicationRecord
    include Swagger::Blocks

    swagger_component do
      schema :Dinosaur do
        key :id, :Dinosaur
        key :type, :object
        key :required, %i[name species]

        property :id do
          key :type, :string
          key :format, :uuid_v4
          key :description, 'unique identifier for the dinosaur, required in update, delete, and show operations'
        end

        property :name do
          key :type, :string
          key :description, 'unique name for the dinosaur'
        end

        property :diet do
          key :type, :string
          key :enum, Park::Dinosaurs::DIET
          key :description, 'dinosaur diet (read only)'
        end

        property :species do
          key :type, :string
          key :enum, Park::Dinosaurs::SPECIES
          key :description, 'the dinosaur species'
        end
      end
    end
  end
end
