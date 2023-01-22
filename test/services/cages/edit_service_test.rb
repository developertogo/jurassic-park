# frozen_string_literal: true

require 'test_helper'

module Cages
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage)
      @params = attributes_for(:cage)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should update cage successfully' do
      params[:id] = cage.id

      assert_changes -> { cage.updated_at } do
        service = Cages::EditService.new(params:, doorkeeper_application:).call

        cage.reload

        assert service.success?
        assert_equal 'Cage saved!', service.success
      end
    end
  end
end
