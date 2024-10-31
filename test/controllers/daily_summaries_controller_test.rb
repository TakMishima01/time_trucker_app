require "test_helper"

class DailySummariesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get daily_summaries_index_url
    assert_response :success
  end

  test "should get edit" do
    get daily_summaries_edit_url
    assert_response :success
  end
end
