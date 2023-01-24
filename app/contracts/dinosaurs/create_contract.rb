# frozen_string_literal: true

# require './app/lib/park.rb'

module Dinosaurs
  class CreateContract < ApplicationContract
    params do
      values = Park::Dinosaurs::SPECIES.map { |s| s.to_s.downcase }
      required(:name) { filled? & str? } # & UniqueNameDinosaurSchema.call(id: :id, attr_name: 'name', name: :name) }
      required(:species).filled(Types::String.enum(*values))
      required(:cage_id) { filled? & uuid_v4? } # & FindCageSchema.call(id: :id) }
    end
  end
end
