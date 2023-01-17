# frozen_string_literal: true

module Dinosaurs
  class EditContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)

      specieses = Park::Dinosaur::SPECIES.map { |s| s.to_s.downcase }
      optional(:name) { maybe? & str? & unique?(Dinosaur, :name) }
      #optional(:name).maybe(str?, unique?(Dinosaur, :name)
      optional(:species).maybe(Types::String.enum(*specieses))
    end
  end
end
