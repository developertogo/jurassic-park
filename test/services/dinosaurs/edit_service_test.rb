# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :params, :dinosaur, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur)
      @params = attributes_for(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should update dinosaur successfully' do
      cage = create(:cage)
      params[:id] = dinosaur.id
      params[:cage_id] = cage.id

      assert_changes -> { dinosaur.updated_at } do
        service = Dinosaurs::EditService.new(params:, doorkeeper_application:).call

        dinosaur.reload

        assert service.success?
        assert_equal 'Dinosaur saved!', service.success
      end
    end
  end
end
