# frozen_string_literal: true

require 'test_helper'

module Cages
  class EditServiceTest < ActiveSupport::TestCase
    attr_reader :cage

    def setup
      @cage = create(:cage)
    end

    test 'should update cage successfully' do
      params = { tag: Faker::Number.unique.leading_zero_number(digits: 3),
                 power_status: Park::Cage::POWER_STATUS[0],
                 location: Faker::Lorem.words(number: 1)[0] }

      assert_changes -> { cage.updated_at } do
        service = Cages::EditService.new(parmas:).call

        cage.reload

        assert service.success?
        # TODO: test message
        #assert_equal I18n.t(''), service.success[:message]
      end
    end

    test 'should not update cage if required location attribute is nil' do
      params = { tag: Faker::Number.unique.leading_zero_number(digits: 3),
                 power_status: Park::Cage::POWER_STATUS[0] }

      assert_no_changes -> { cage.updated_at } do
        service = Cages::EditService.new(params:).call

        cage.reload

        assert service.failure?
      end
    end
  end
end
