# frozen_string_literal: true

module Inputs
  module V1
    class CagesInput
      include Swagger::Blocks

      swagger_component do
        schema :CagesInput do
          key :required, %i[email password client_id client_secret]

          # t.string "tag", null: false
          # t.enum "power_status", null: false, enum_type: "power_statuses"
          # t.integer "dinosaur_count", default: 0, null: false
          # t.integer "max_capacity", default: 1, null: false
          # t.string "location", null: false

          property :tag do
            key :type, :string
            key :example, 'C-test'
          end

          property :power_status do
            key :type, :enum 
            key :example, 'down'
          end

          property :client_id do
            key :type, :string
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          property :client_secret do
            key :type, :string
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end
        end
      end
    end
  end
end
