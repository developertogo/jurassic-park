# frozen_string_literal: true

module Cages
  class FetchContract < ApplicationContract
    params do
      optional(:id).maybe(:uuid_v4?)
    end
  end
end
