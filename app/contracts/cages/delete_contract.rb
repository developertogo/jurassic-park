# frozen_string_literal: true

module Cages
  class DeleteContract < ApplicationContract
    params do
      required(:id).filled(:uuid_v4?)
    end
  end
end
