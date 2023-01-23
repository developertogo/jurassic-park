# frozen_string_literal: true

module Controllers
  module V1
      class CagesController
        include Swagger::Blocks

        swagger_path '/v1/cages' do
          operation :post do
            key :summary, 'Manage Cages'
            key :description, 'Create a new user and generate access and refresh tokens'
            key :operationId, 'userSignUp'
            key :tags, [
              'Cages'
            ]

            request_body do
              key :description, 'User credentials'
              key :required, true
              content :'application/json' do
                schema do
                  key :'$ref', :UserSignUpInput
                end
              end
            end

            response 201 do
              key :description, 'Successful response'
              content :'application/json' do
                schema do
                  key :'$ref', :UserSignUpSuccessResponse
                end
              end
            end

            response 422 do
              key :description, 'Something goes wrong'
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
