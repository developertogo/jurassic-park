require "test_helper"

class CagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cage = cages(:one)
  end

  test "should get index" do
    get cages_url, as: :json
    assert_response :success
  end

  test "should create cage" do
    assert_difference("Cage.count") do
      post cages_url, params: { cage: { dinosaur_count: @cage.dinosaur_count, location: @cage.location, max_capacity: @cage.max_capacity, power_status: @cage.power_status, tag: @cage.tag } }, as: :json
    end

    assert_response :created
  end

  test "should show cage" do
    get cage_url(@cage), as: :json
    assert_response :success
  end

  test "should update cage" do
    patch cage_url(@cage), params: { cage: { dinosaur_count: @cage.dinosaur_count, location: @cage.location, max_capacity: @cage.max_capacity, power_status: @cage.power_status, tag: @cage.tag } }, as: :json
    assert_response :success
  end

  test "should destroy cage" do
    assert_difference("Cage.count", -1) do
      delete cage_url(@cage), as: :json
    end

    assert_response :no_content
  end
end
