# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class CreateServiceTest < ActiveSupport::TestCase
    attr_reader :params

    def setup
      @params = attributes_for(:dinosaur)
    end

    test 'should create dinosaur' do
      assert_difference 'Dinosaur.count', 1 do
        service = Dinosaurs::CreateService.new(params:).call

        assert service.success?
      end
    end

    test 'should fail if something goes wrong' do
      Dinosaur.any_instance.expects(:save).returns(false)

      assert_no_difference 'Dinosaur.count' do
        service = Dinosaurs::CreateService.new(params:).call

        assert service.failure?
      end
    end
  end
end
