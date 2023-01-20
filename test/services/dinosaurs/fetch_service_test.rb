# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class FetchServiceTest < ActiveSupport::TestCase
    attr_reader :params, :dinosaur, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should fetch dinosaur successfully' do
      assert_nothing_raised do
        params = { id: dinosaur.id } 
        service = Dinosaurs::FetchService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should fetch dinosaur list sucessfully' do
      assert_nothing_raised do
        service = Dinosaurs::FetchService.new(params: {}, doorkeeper_application:).call

        assert service.success?
      end
    end

    test 'should not fetch dinosaur with an unknown id' do
      assert_raise 'ActiveRecord::RecordNotFound' do
        params = { id: 0 }
        service = Dinosaurs::FetchService.new(params:, doorkeeper_application:).call

        assert service.success?
      end
    end
  end
end
