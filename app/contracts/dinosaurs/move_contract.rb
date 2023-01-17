# frozen_string_literal: true

module Dinosaurs
  class MoveContract < ApplicationContract
    params do
      # configure do
      #   def is_kind?(class, value)
      #     class.where(id: value).any?
      #   end
      # end
    
      required(:id) { filled? & uuid_v4? & is_kind?(Dinosaur) }
      required(:cage_id) { filled? & uuid_v4? & is_kind?(Cage) }
      #required(:id) { filled? & uuid_v4? }
      #required(:cage_id) { filled? & uuid_v4? }
    end
  end
end
