# frozen_string_literal: true

module Inputs
  module V1
    class DinosaurCreateInput
      include Swagger::Blocks

      swagger_component do
        schema :DinosaurCreateInput do
          key :required, %i[name species client_id client_secret]

          property :name do
            key :type, :string
            key :description, 'unique name for the dinosaur'
            key :example, 'T Rex'
          end

          property :species do
            key :type, :string
            key :enum, Park::Dinosaurs::SPECIES
            key :description, 'cage species'
            key :example, Park::Dinosaurs::SPECIES[0]
          end

          property :cage_id do
            key :type, :uuid_v4
            key :description, 'uuid of cage where dinosaur will be contained'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end
        end
      end
    end
  end
end
