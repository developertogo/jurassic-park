# frozen_string_literal: true

module Cages
  class EditContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)

      values = Park::Cage::POWER_STATUS.map { |v| v.to_s.downcase }
      optional(:tag) { str? } #& UniqueNameCageSchema.call(id: :id, attr_name: 'tag', name: :tag) } 

      optional(:power_status).maybe(Types::String.enum(*values))
      # another alternative
      #optional(:power_status).filled(included_in?: *values)
      optional(:location).maybe(:string)
    end
  end
end
