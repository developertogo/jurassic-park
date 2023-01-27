# frozen_string_literal: true

module Controllers
  module V1
    class DinosaursController # rubocop:disable Metrics/ClassLength
      include Swagger::Blocks

      # GET /v1/dinosaurs
      swagger_path '/v1/dinosaurs' do
        operation :get do
          key :summary, 'List of dinosaurs with a filter option'
          key :description, 'Get list of dinosaurs with an option to filter by `species`'
          key :operationId, 'dinosaurList'
          key :tags, [
            'Dinosaurs'
          ]

          parameter do
            key :name, :query
            key :in, :query
            key :required, false
            key :type, :string
            key :description, "filter by: `species_eq` : *#{Park::Dinosaurs::SPECIES.map(&:to_s).join(' | ')}*\n\n*Example: \{\"species_eq\": \"#{Park::Dinosaurs::SPECIES[0]}\"\}*"
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
                key :'$ref', :DinosaurListSuccessResponse
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

      # POST /v1/dinosaurs
      swagger_path '/v1/dinosaurs' do
        operation :post do
          key :summary, 'Create dinosaur'
          key :description, 'Create a new dinosaur'
          key :operationId, 'dinosaurCreate'
          key :tags, [
            'Dinosaurs'
          ]

          request_body do
            key :description, 'Dinosaur attributes'
            key :required, true
            content :'application/json' do
              schema do
                key :'$ref', :DinosaurCreateInput
              end
            end
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

          response 201 do
            key :description, 'Successful response'
            content :'application/json' do
              schema do
                # key :'$ref', :DinosaurCreateSuccessResponse
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

      # GET /v1/dinosaurs/{id}
      swagger_path '/v1/dinosaurs/{id}' do
        operation :get do
          key :summary, 'Show dinosaur'
          key :description, 'Show the dinosaur details'
          key :operationId, 'dinosaurShow'
          key :tags, [
            'Dinosaurs'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of dinosaur to be fetched'
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
                key :'$ref', :DinosaurShowSuccessResponse
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

      # PATCH /v1/dinosaurs
      swagger_path '/v1/dinosaurs/{id}' do
        operation :patch do
          key :summary, 'Update dinosaur'
          key :description, 'Update the dinosaur'
          key :operationId, 'dinosaurUpdate'
          key :tags, [
            'Dinosaurs'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of dinosaur to be updated'
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
            key :description, 'Dinosaur attributes'
            key :required, true
            content :'application/json' do
              schema do
                key :'$ref', :DinosaurUpdateInput
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

      # PATCH v1/dinosaurs/{id}/move/{cage_id}
      swagger_path '/v1/dinosaurs/{id}/move/{cage_id}' do
        operation :patch do
          key :summary, 'Move dinosaur'
          key :description, 'Move the dinosaur'
          key :operationId, 'dinosaurMove'
          key :tags, [
            'Dinosaurs'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of dinosaur to be moved'
          end

          parameter do
            key :name, :cage_id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of cage where dinosaur is moving to'
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

      # DELETE /v1/dinosaurs/{id}
      swagger_path '/v1/dinosaurs/{id}' do
        operation :delete do
          key :summary, 'Delete dinosaur'
          key :description, 'Delete the dinosaur'
          key :operationId, 'dinosaurDelete'
          key :tags, [
            'Dinosaurs'
          ]

          parameter do
            key :name, :id
            key :in, :path
            key :required, true
            key :type, :uuid_v4
            key :description, 'uuid of dinosaur to be deleted'
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
    end
  end
end
