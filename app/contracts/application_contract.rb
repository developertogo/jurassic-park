# frozen_string_literal: true

require 'dry-validation'

class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n

  UniqueNameCageSchema = Dry::Schema.Params do
      required(:id).value { uuid_v4? }
      required(:attr_name).value(:string)
      required(:name).value(:string)

      def unique?(id, attr_name, value)
        Cage.where.not(id: id).where(attr_name => name).empty?
      end
  end

  UniqueNameDinosaurSchema = Dry::Schema.Params do
      required(:id).value { uuid_v4? }
      required(:attr_name).value(:string)
      required(:name).value(:string)

      def unique?(id, attr_name, name)
        Dinosaur.where.not(id: id).where(attr_name => name).empty?
      end
  end

  FindCageSchema = Dry::Schema.Params do
    required(:id).value { uuid_v4? }

      def find_by_id(id)
        Cage.where(id: id).any?
      end
  end

  FindDinosaurSchema = Dry::Schema.Params do
    required(:id).value { uuid_v4? }

      def find_by_id(value)
        Dinosaur.where(id: value).any?
      end
  end

  register_macro(:password_confirmation) do
    key.failure(:same_password?) unless values[:password].eql?(values[:password_confirmation])
  end
end
