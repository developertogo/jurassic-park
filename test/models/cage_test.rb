# frozen_string_literal: true

require "test_helper"

class CageTest < ActiveSupport::TestCase
  test 'should have a valid factory' do
    assert create(:cage).persisted?
  end

  context '#indexes' do
    should have_db_index(:tag).unique(true)
    should have_db_index(:power_status)
  end
end
