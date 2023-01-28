# frozen_string_literal: true

class SwaggerDocs
  include Swagger::Blocks

  COMMON_SWAGGERED_CLASSES = [
    ## Models ##
    Models::Shared::Pagination,
    Models::Shared::Meta,
    ## Responses ##
    Responses::Shared::ErrorResponse
  ].freeze

  V1_SWAGGERED_CLASSES = [
    ## Controllers ##
    Controllers::V1::Users::TokensController,
    Controllers::V1::Users::RegistrationsController,
    Controllers::V1::Users::PasswordsController,
    Controllers::V1::CagesController,
    Controllers::V1::DinosaursController,
    ## Inputs ##
    Inputs::V1::User::SignInInput,
    Inputs::V1::User::SignUpInput,
    Inputs::V1::User::ResetPasswordInput,
    Inputs::V1::User::UpdatePasswordInput,
    Inputs::V1::User::RevokeInput,
    Inputs::V1::CageCreateInput,
    Inputs::V1::CageUpdateInput,
    Inputs::V1::DinosaurCreateInput,
    Inputs::V1::DinosaurUpdateInput,
    ## Responses ##
    Responses::V1::User::SignInResponse,
    Responses::V1::User::SignUpResponse,
    Responses::V1::User::ResetPasswordResponse,
    Responses::V1::User::UpdatePasswordResponse,
    Responses::V1::CageCreateResponse,
    Responses::V1::CageListResponse,
    Responses::V1::CageShowResponse,
    Responses::V1::DinosaurCreateResponse,
    Responses::V1::DinosaurListResponse,
    Responses::V1::DinosaurShowResponse,
    ## Models ##
    Models::Cage,
    Models::Dinosaur,
    self
  ].concat(COMMON_SWAGGERED_CLASSES)

  V2_SWAGGERED_CLASSES = [
    self
  ].concat(COMMON_SWAGGERED_CLASSES)

  swagger_root do
    key :openapi, '3.0.0'

    info do
      key :version, '1.0.0'
      key :title, 'Jurassic Park API'
      key :description, 'Jurassic Park API'

      contact do
        key :name, 'Carlos Hung'
        key :url, 'https://github.com/developertogo'
        key :email, 'developertogo@gmail.com'
      end
    end

    server do
      url_options = Rails.application.routes.default_url_options
      key :url, "#{url_options[:protocol]}://#{url_options[:host]}"
      key :description, 'Jurassic Park API'
    end
  end

  class << self
    def v1_swagger_root
      build_swagger_root(V1_SWAGGERED_CLASSES)
    end

    def v2_swagger_root
      build_swagger_root(V2_SWAGGERED_CLASSES)
    end

    private

    def build_swagger_root(classes)
      swagger_data = Swagger::Blocks.build_root_json(classes)

      swagger_data[:components][:securitySchemes] = {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT'
        }
      }

      swagger_data[:security] = [{ bearerAuth: [] }]

      swagger_data
    end
  end
end
