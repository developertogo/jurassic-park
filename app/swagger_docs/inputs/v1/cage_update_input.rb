# frozen_string_literal: true

module Inputs
  module V1
    class CageUpdateInput
      include Swagger::Blocks

      swagger_component do
        schema :CageUpdateInput do
          key :required, %i[tag power_status max_capacity location client_id client_secret]

          property :tag do
            key :type, :string
            key :description, 'unique name for the cage'
            key :example, 'C-test'
          end

          property :power_status do
            key :type, :string
            key :enum, Park::Cages::POWER_STATUS
            key :description, 'cage power status'
            key :example, Park::Cages::POWER_STATUS[0]
          end

          property :max_capacity do
            key :type, :integer
            key :description, 'how many dinosaurs the cage can hold'
            key :example, 8
          end

          property :location do
            key :type, :string
            key :example, 'SFO'
            key :description, 'cage location name'
          end
        end
      end
    end
  end
end
