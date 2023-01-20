# frozen_string_literal: true
#require './app/lib/park.rb'

module Dinosaurs
  class CreateContract < ApplicationContract
    params do
      specieses = Park::Dinosaur::SPECIES.map { |s| s.to_s.downcase }
      required(:name) { filled? & str? } # & UniqueNameDinosaurSchema.call(id: :id, attr_name: 'name', name: :name) }
      required(:species).filled(Types::String.enum(*specieses))
      required(:cage_id) { filled? & uuid_v4? } #& FindCageSchema.call(id: :id) }
    end
  end
end
