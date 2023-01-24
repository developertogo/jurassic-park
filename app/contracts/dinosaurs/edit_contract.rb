# frozen_string_literal: true

module Dinosaurs
  class EditContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)

      values = Park::Dinosaurs::SPECIES.map { |s| s.to_s.downcase }
      optional(:name) { str? }
      optional(:species).maybe(Types::String.enum(*values))
      optional(:cage_id) { filled? & uuid_v4? }
    end
  end
end
