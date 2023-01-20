require "test_helper"

module V1
  class DinosaursControllerTest < ActionDispatch::IntegrationTest
    attr_reader :doorkeeper_application
    attr_accessor :params

    setup do
      @cage = create(:cage)
      @dinosaur = create(:dinosaur) 
      @params = attributes_for(:dinosaur)
      @params[:cage_id] = @cage.id
      @doorkeeper_application = create(:doorkeeper_application)
      @params[:client_id] = doorkeeper_application.uid
      @params[:client_secret] = doorkeeper_application.secret
    end

    test "should get index" do
      get v1_dinosaurs_url, params:, as: :json
      assert_response :success
    end

    test "should create dinosaur" do
      assert_difference("Dinosaur.count", 1) do
        post v1_dinosaurs_url, params:, as: :json
      end

      assert_response :created
    end

    test "should show dinosaur" do
      get v1_dinosaurs_url(@dinosaur), params:, as: :json
      assert_response :success
    end

    test "should update dinosaur" do
      patch v1_dinosaurs_url(@dinosaur), params:, as: :json
      assert_response :success
    end

    # test "should destroy dinosaur" do
    #   skip("funcionality not implemented yet")
    #   assert_difference("Dinosaur.count", -1) do
    #     delete dinosaurs_url(@dinosaur), as: :json
    #   end

    #   assert_response :no_content
    # end
  end
end
