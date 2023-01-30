# frozen_string_literal: true

# require './app/lib/park'

module Responses
  module V1
    class DinosaurShowResponse
      include Swagger::Blocks

      swagger_component do
        schema :DinosaurShowSuccessResponse do
          key :type, :object
          key :required, %i[id name diet species]

          property :id do
            key :type, :string
            key :format, :uuid_v4
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          property :name do
            key :type, :string
            key :example, 'T Rex'
          end

          property :diet do
            key :type, :string
            key :example, Park::Dinosaurs::DIET
          end

          property :species do
            key :type, :string
            key :example, Park::Dinosaurs::SPECIES
          end

          property :created_at do
            key :type, :string
            key :example, 'Tue, 24 Jan 2023 15:03:07.44 UTC +00:00'
          end
        end
      end
    end
  end
end
