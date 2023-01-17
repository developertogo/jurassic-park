# frozen_string_literal: true

module Dinosaurs
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
    end
  end
end
