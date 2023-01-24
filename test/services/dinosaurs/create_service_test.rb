# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class CreateServiceTest < ActiveSupport::TestCase
    attr_reader :params, :doorkeeper_application

    def setup
      @params = attributes_for(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
      @cage = create(:cage)
    end

    test 'should create dinosaur' do
      assert_difference 'Dinosaur.count', 1 do
        params[:cage_id] = @cage.id
        service = Dinosaurs::CreateService.new(params:, doorkeeper_application:).call

        dinosaur = service.success

        assert service.success?
        assert_equal params[:cage_id], dinosaur[:cage_id]
        assert_equal params[:cage_id], dinosaur.cage.id
      end
    end

    test 'should fail if something goes wrong' do
      Dinosaur.any_instance.expects(:save).returns(false)

      assert_no_difference 'Dinosaur.count' do
        service = Dinosaurs::CreateService.new(params:, doorkeeper_application:).call

        assert service.failure?
      end
    end
  end
end
