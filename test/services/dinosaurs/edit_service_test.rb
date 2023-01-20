# frozen_string_literal: true

require 'test_helper'

module Dinosaurs
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :params, :dinosaur, :doorkeeper_application

    def setup
      @dinosaur = create(:dinosaur)
      @doorkeeper_application = create(:doorkeeper_application)
    end

    test 'should update dinosaur successfully' do
      cage = create(:cage)
      params = { id: dinosaur.id,
                 name: Faker::Name.name,
                 diet: Park::Dinosaur::DIET[0],
                 species: Park::Dinosaur::SPECIES[0],
                 cage_id: cage.id }

      assert_changes -> { dinosaur.updated_at } do
        service = Dinosaurs::EditService.new(params:, doorkeeper_application:).call

        dinosaur.reload

        assert service.success?
        # TODO: test message
        #assert_equal I18n.t(''), service.success[:message]
      end
    end

    # test 'should not update dinosaur if it is not assigned to a cage' do
    #   params = { name: Faker::Name.name,
    #              diet: Park::Dinosaur::DIET[0],
    #              species: Park::Dinosaur::SPECIES[0] }

    #   assert_no_changes { dinosaur.updated_at } do
    #     service = Dinosaurs::EditService.new(params:, doorkeeper_application:).call

    #     dinosaur.reload

    #     assert service.failure?
    #   end
    # end
  end
end
