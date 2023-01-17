# frozen_string_literal: true

require 'test_helper'

module Cages
  class FetchServiceTest < ActiveSupport::TestCase
    attr_reader :cage

    def setup
      @cage = create(:cage)
    end

    test 'should fetch cage successfully' do
      assert_nothing_raised do
        service = Cages::FetchService.new({ id: cage.id }).call

        assert service.success?
      end
    end

    test 'should fetch cage list sucessfully' do
      assert_nothing_raised do
        service = Cages::FetchService.new({}).call

        assert service.success?
      end
    end

    test 'should not fetch cage with an unknown id' do
      assert_no_difference 'Cage not found' do
        service = Cages::FetchService.new({ id: 0 }).call

        assert service.failure?
      end
    end

    test 'should fail to fetch if something goes wrong' do
      Cage.any_instance.expects(:find).returns(false)

      assert_no_difference 'Cage fetch' do
        service = Cages::CreateService.new({ id: cage.id }).call

        assert service.failure?
      end
    end
  end
end
