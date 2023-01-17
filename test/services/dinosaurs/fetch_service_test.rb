# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class FetchServiceTest < ActiveSupport::TestCase
    attr_reader :dinosaur

    def setup
      @dinosaur = create(:dinosaur)
    end

    test 'should fetch dinosaur successfully' do
      assert_nothing_raised do
        service = Dinosaurs::FetchService.new({ id: dinosaur.id }).call

        assert service.success?
      end
    end

    test 'should fetch dinosaur list sucessfully' do
      assert_nothing_raised do
        service = Dinosaurs::FetchService.new({}).call

        assert service.success?
      end
    end

    test 'should not fetch dinosaur with an unknown id' do
      assert_no_difference 'Dinosaurs not found' do
        service = Dinosaurs::FetchService.new({ id: 0 }).call

        assert service.failure?
      end
    end

    test 'should fail to fetch if something goes wrong' do
      Dinosaur.any_instance.expects(:find).returns(false)

      assert_no_difference 'Dinosaur fetch' do
        service = Dinosaurs::CreateService.new({ id: dinosaur.id }).call

        assert service.failure?
      end
    end
  end
end
