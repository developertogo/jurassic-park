# frozen_string_literal: true

require 'test_helper'

module Cages
  class DeleteServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should delete cage successfully' do
      params = { id: @cage.id }

      assert_difference 'Cage.count', -1 do
        service = Cages::DeleteService.new(params:, doorkeeper_application:).call

        assert service.success?
        # TODO: test message
        #assert_equal I18n.t(''), service.success[:message]
      end
    end
  end
end
