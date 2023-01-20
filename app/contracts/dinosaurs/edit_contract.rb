# frozen_string_literal: true

module Dinosaurs
  class EditContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)

      specieses = Park::Dinosaur::SPECIES.map { |s| s.to_s.downcase }
      optional(:name) { str? } # & UniqueNameDinosaurSchema.call(id: :id, attr_name: 'name', name: :name) }
      optional(:species).maybe(Types::String.enum(*specieses))
    end
  end
end
