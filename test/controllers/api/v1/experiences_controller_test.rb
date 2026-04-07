require "test_helper"

class Api::V1::ExperiencesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_experiences_create_url
    assert_response :success
  end
end
