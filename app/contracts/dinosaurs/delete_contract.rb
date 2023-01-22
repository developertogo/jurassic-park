# frozen_string_literal: true

module Dinosaurs
  class DeleteContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)
    end
  end
end
