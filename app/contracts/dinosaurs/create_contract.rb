# frozen_string_literal: true
#require './app/lib/park.rb'

module Dinosaurs
  class CreateContract < ApplicationContract
    params do
      specieses = Park::Dinosaur::SPECIES.map { |s| s.to_s.downcase }
      required(:name) { filled? & str? & unique?(Dinosaur, :name) }
      required(:species).filled(Types::String.enum(*specieses))
      required(:cage_id) { filled? & uuid_v4? & is_kind?(Cage) }
    end
  end
end
