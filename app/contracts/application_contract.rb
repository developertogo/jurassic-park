# frozen_string_literal: true

require 'dry-validation'

class ApplicationContract < Dry::Validation::Contract
  config.messages.backend = :i18n

  config do
    option :record

    def is_kind?(class_type, value)
      class_type.where(id: value).any?
    end

    def unique? (class_type, attr_name, value)
      record.class.where.not(id: id).where(attr_name => value).empty?
      #record.class.where.not(id: record.id).where(attr_name => value).empty?
    end
  end

  register_macro(:password_confirmation) do
    key.failure(:same_password?) unless values[:password].eql?(values[:password_confirmation])
  end
end
