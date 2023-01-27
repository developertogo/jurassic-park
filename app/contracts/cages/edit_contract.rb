# frozen_string_literal: true

module Cages
  class EditContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)

      values = Park::Cages::POWER_STATUS.map { |v| v.to_s.downcase }
      optional(:tag) { str? }

      optional(:power_status).maybe(Types::String.enum(*values))
      # another alternative
      # optional(:power_status).maybe(included_in?: values)
      optional(:location).maybe(:string)
    end
  end
end
