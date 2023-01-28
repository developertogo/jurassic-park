# frozen_string_literal: true

require './app/lib/park'

module Models
  class Cage < ApplicationRecord
    include Swagger::Blocks

    swagger_component do
      schema :Cage do
        key :id, :Cage
        key :type, :object
        key :required, %i[tag power_status max_capacity location]

        property :id do
          key :type, :string
          key :format, :uuid_v4
          key :description, 'unique uuid identifier for the cage, required in update, delete, and show operations'
        end

        property :tag do
          key :type, :string
          key :description, 'unique name for the cage'
        end

        property :power_status do
          key :type, :string
          key :enum, Park::Cages::POWER_STATUS
          key :description, 'cage power status'
        end

        property :dinosaurs_count do
          key :type, :integer
          key :format, :int32
          key :description, 'number of dinosaurs contained in the cage (read only)'
          key :minimum, 1
          key :maximum, Park::Cages::MAX_CAPACITY
        end

        property :max_capacity do
          key :type, :integer
          key :format, :int32
          key :minimum, 1
          key :maximum, Park::Cages::MAX_CAPACITY
          key :description, 'how many dinosaurs the cage can hold'
        end

        property :location do
          key :type, :string
          key :description, 'cage location name'
        end
      end
    end
  end
end
