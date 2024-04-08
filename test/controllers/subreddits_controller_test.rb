require "test_helper"

class SubredditsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @subreddit = subreddits(:one)
  end

  test "should get index" do
    get subreddits_url
    assert_response :success
  end

  test "should get new" do
    get new_subreddit_url
    assert_response :success
  end

  test "should create subreddit" do
    assert_difference("Subreddit.count") do
      post subreddits_url, params: { subreddit: { body: @subreddit.body, title: @subreddit.title, user_id: @subreddit.user_id } }
    end

    assert_redirected_to subreddit_url(Subreddit.last)
  end

  test "should show subreddit" do
    get subreddit_url(@subreddit)
    assert_response :success
  end

  test "should get edit" do
    get edit_subreddit_url(@subreddit)
    assert_response :success
  end

  test "should update subreddit" do
    patch subreddit_url(@subreddit), params: { subreddit: { body: @subreddit.body, title: @subreddit.title, user_id: @subreddit.user_id } }
    assert_redirected_to subreddit_url(@subreddit)
  end

  test "should destroy subreddit" do
    assert_difference("Subreddit.count", -1) do
      delete subreddit_url(@subreddit)
    end

    assert_redirected_to subreddits_url
  end
end
