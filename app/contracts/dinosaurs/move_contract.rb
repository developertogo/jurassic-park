# frozen_string_literal: true

module Dinosaurs
  class MoveContract < ApplicationContract
    params do
      required(:id) { filled? & uuid_v4? } # & FindDinosaurSchema.call(id: :id) }
      required(:cage_id) { filled? & uuid_v4? } # & FindCageSchema.call(cage_id: :cage_id) }
    end
  end
end
