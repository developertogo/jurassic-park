# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class DeleteServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should delete cage successfully' do
      params = { id: @dinosaur.id }

      assert_difference 'Dinosaur.count', -1 do
        service = Dinosaurs::DeleteService.new(params:, doorkeeper_application:).call

        assert service.success?
        # TODO: test message
        #assert_equal I18n.t(''), service.success[:message]
      end
    end
  end
end
