# frozen_string_literal: true

require 'test_helper'

module Cages
  class FetchServiceTest < ActiveSupport::TestCase
    attr_reader :params, :cage, :doorkeeper_application

    def setup
      @cage = create(:cage)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should fetch cage successfully' do
      assert_nothing_raised do
        params = { id: cage.id }
        service = Cages::FetchService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should fetch cage list sucessfully' do
      assert_nothing_raised do
        service = Cages::FetchService.new(params: {}, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should not fetch cage with an unknown id' do
      assert_raise 'ActiveRecord::RecordNotFound' do
        params = { id: 0 }
        service = Cages::FetchService.new(params:, doorkeeper_application:).call

        assert service.failure?
      end
    end
  end
end
