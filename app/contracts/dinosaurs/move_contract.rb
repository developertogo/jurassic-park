# frozen_string_literal: true

module Dinosaurs
  class MoveContract < ApplicationContract
    params do
      required(:id) { filled? & uuid_v4? }
      required(:cage_id) { filled? & uuid_v4? }
    end
  end
end
