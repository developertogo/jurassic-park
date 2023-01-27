# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :params, :dinosaur, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur, species: :moschops)
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
      end
    end

    test 'should update dinosaur\'s diet when it\'s species changes' do
      params[:id] = dinosaur.id
      params[:species] = :acrocanthosaurus

      assert_changes -> { dinosaur.updated_at } do
        service = Dinosaurs::EditService.new(params:, doorkeeper_application:).call

        dinosaur.reload

        assert service.success?
        assert_equal :carnivores.to_s, dinosaur.diet
      end
    end
  end
end
