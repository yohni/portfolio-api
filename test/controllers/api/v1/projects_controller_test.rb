require "test_helper"

class Api::V1::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_projects_create_url
    assert_response :success
  end
end
