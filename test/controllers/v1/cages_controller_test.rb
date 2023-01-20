# frozen_string_literal: true

require "test_helper"

module V1
  class CagesControllerTest < ActionDispatch::IntegrationTest
    attr_reader :doorkeeper_application
    attr_accessor :params

    setup do
      @cage = create(:cage)
      @params = attributes_for(:cage)
      @doorkeeper_application = create(:doorkeeper_application)
      @params[:client_id] = doorkeeper_application.uid
      @params[:client_secret] = doorkeeper_application.secret
    end

    test "should get index" do
      get v1_cages_url, params:, as: :json
      assert_response :success
    end

    test "should create cage" do
      assert_difference("Cage.count", 1) do
        post v1_cages_url, params:, as: :json
      end

      assert_response :created
    end

    test "should show cage" do
      get v1_cages_url(@cage), params:, as: :json
      assert_response :success
    end

    test "should update cage" do
      patch v1_cages_url(@cage), params:, as: :json
      assert_response :success
    end

    # test "should destroy cage" do
    #   skip("funcionality not implemented yet")
    #   assert_difference("Cage.count", -1) do
    #     delete v1_cages_url(@cage), as: :json
    #   end

    #   assert_response :no_content
    # end
  end
end