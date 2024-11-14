require "test_helper"

class StudySessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get study_sessions_new_url
    assert_response :success
  end
end
