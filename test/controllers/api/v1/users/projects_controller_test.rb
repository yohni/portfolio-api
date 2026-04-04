require "test_helper"

class Api::V1::Users::ProjectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_users_projects_index_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_users_projects_show_url
    assert_response :success
  end
end
