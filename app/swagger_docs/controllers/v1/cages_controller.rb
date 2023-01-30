# frozen_string_literal: true

module Controllers
  module V1
    class CagesController # rubocop:disable Metrics/ClassLength
      include Swagger::Blocks

      # GET /v1/cages
      swagger_path '/v1/cages' do
        operation :get do
          key :summary, 'List of cages with a filter option'
          key :description, 'Get list of cages with an **option** to filter by `power_status` or `dinosaur`'
          key :operationId, 'cageList'
          key :tags, [
            'Cages'
          ]

          parameter do
            key :name, :query
            key :in, :query
            key :required, false
            key :type, :string
            key :description, "filter by: `power_status_eq` : *#{Park::Cages::POWER_STATUS.map(&:to_s).join(' | ')}* as JSON\n\n" \
                              "*Example: \{\"power_status_eq\": \"#{Park::Cages::POWER_STATUS[0]}*\"\}"
          end

          parameter do
            key :name, :client_id
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_id (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          parameter do
            key :name, :client_secret
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_secret (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          response 200 do
            key :description, 'Successful response'
            content :'application/json' do
              schema do
                key :'$ref', :CageListSuccessResponse
              end
            end
          end

          response 422 do
            key :description, 'Something went wrong'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end

          response 401 do
            key :description, 'Invalid client credentials passed'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end
        end
      end

      # POST /v1/cages
      swagger_path '/v1/cages' do
        operation :post do
          key :summary, 'Create cage'
          key :description, 'Create a new cage'
          key :operationId, 'cageCreate'
          key :tags, [
            'Cages'
          ]

          parameter do
            key :name, :client_id
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_id (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          parameter do
            key :name, :client_secret
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_secret (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          request_body do
            key :description, 'Cage attributes'
            key :required, true
            content :'application/json' do
              schema do
                key :'$ref', :CageCreateInput
              end
            end
          end

          response 201 do
            key :description, 'Successful response'
            content :'application/json' do
              schema do
                key :'$ref', :CageCreateSuccessResponse
              end
            end
          end

          response 422 do
            key :description, 'Something went wrong'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end

          response 401 do
            key :description, 'Invalid client credentials passed'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end
        end
      end

      # GET /v1/cages/{id}
      swagger_path '/v1/cages/{id}' do
        operation :get do
          key :summary, 'Show cage with a filter option'
          key :description, 'Show the cage details'
          key :operationId, 'cageShow'
          key :tags, [
            'Cages'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of cage to be fetched'
          end

          parameter do
            key :name, :query
            key :in, :query
            key :required, false
            key :type, :string
            key :description, "filter by: *`dinosaurs`* as JSON\n\n\n *Example: \{\"dinosaurs\": \"\"\}*"
          end

          parameter do
            key :name, :client_id
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_id (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          parameter do
            key :name, :client_secret
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_secret (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          response 200 do
            key :description, 'Successful response'
            content :'application/json' do
              schema do
                key :'$ref', :CageShowSuccessResponse
              end
            end
          end

          response 422 do
            key :description, 'Something went wrong'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end

          response 401 do
            key :description, 'Invalid client credentials passed'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end
        end
      end

      # PATCH /v1/cages
      swagger_path '/v1/cages/{id}' do
        operation :patch do
          key :summary, 'Update cage'
          key :description, 'Update the cage'
          key :operationId, 'cageUpdate'
          key :tags, [
            'Cages'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of cage to be updated'
          end

          parameter do
            key :name, :client_id
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_id (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          parameter do
            key :name, :client_secret
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_secret (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          request_body do
            key :description, 'Cage attributes'
            key :required, true
            content :'application/json' do
              schema do
                key :'$ref', :CageUpdateInput
              end
            end
          end

          response 204 do
            key :description, 'Successful response'
          end

          response 422 do
            key :description, 'Something went wrong'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end

          response 401 do
            key :description, 'Invalid client credentials passed'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end
        end
      end

      # DELETE /v1/cages/{id}
      swagger_path '/v1/cages/{id}' do
        operation :delete do
          key :summary, 'Delete cage'
          key :description, 'Delete the cage'
          key :operationId, 'cageDelete'
          key :tags, [
            'Cages'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of cage to be deleted'
          end

          parameter do
            key :name, :client_id
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_id (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          parameter do
            key :name, :client_secret
            key :in, :header
            key :required, true
            key :type, :string
            key :description, 'client_secret (OAuth2) to be passed as a header'
            key :example, 'e7c8f8f0-e8e0-4b0f-b8b1-f8f8f8f8f8f8'
          end

          response 204 do
            key :description, 'Success response'
          end

          response 422 do
            key :description, 'Something went wrong'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end

          response 401 do
            key :description, 'Invalid client credentials passed'
            content :'application/json' do
              schema do
                key :'$ref', :ErrorResponse
              end
            end
          end
        end
      end
    end
  end
end
