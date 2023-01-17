# frozen_string_literal: true

require "test_helper"

class DinosaurTest < ActiveSupport::TestCase
  test 'should have a valid factory' do
    assert create(:dinosaur).persisted?
  end

  context '#indexes' do
    should have_db_index(:name).unique(true)
    should have_db_index(:species)
  end
end
