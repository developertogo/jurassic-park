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
        end
      end
    end
  end
end
