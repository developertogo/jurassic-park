# frozen_string_literal: true

# require './app/lib/park'

module Responses
  module V1
    class CageCreateResponse
      include Swagger::Blocks

      swagger_component do
        schema :CageCreateSuccessResponse do
          key :type, :object
          key :required, %i[id tag power_status dinosaurs_count max_capacity location]

          property :id do
            key :type, :string
            key :format, :uuid_v4
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          property :tag do
            key :type, :string
            key :example, 'C-888'
          end

          property :power_status do
            key :type, :string
            key :example, Park::Cages::POWER_STATUS[0]
          end

          property :dinosaurs_count do
            key :type, :integer
            key :example, 0
          end

          property :max_capacity do
            key :type, :integer
            key :example, 2
          end

          property :location do
            key :type, :string
            key :example, 'LAX'
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
