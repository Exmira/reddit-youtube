require "application_system_test_case"

class SubredditsTest < ApplicationSystemTestCase
  setup do
    @subreddit = subreddits(:one)
  end

  test "visiting the index" do
    visit subreddits_url
    assert_selector "h1", text: "Subreddits"
  end

  test "should create subreddit" do
    visit subreddits_url
    click_on "New subreddit"

    fill_in "Body", with: @subreddit.body
    fill_in "Title", with: @subreddit.title
    fill_in "User", with: @subreddit.user_id
    click_on "Create Subreddit"

    assert_text "Subreddit was successfully created"
    click_on "Back"
  end

  test "should update Subreddit" do
    visit subreddit_url(@subreddit)
    click_on "Edit this subreddit", match: :first

    fill_in "Body", with: @subreddit.body
    fill_in "Title", with: @subreddit.title
    fill_in "User", with: @subreddit.user_id
    click_on "Update Subreddit"

    assert_text "Subreddit was successfully updated"
    click_on "Back"
  end

  test "should destroy Subreddit" do
    visit subreddit_url(@subreddit)
    click_on "Destroy this subreddit", match: :first

    assert_text "Subreddit was successfully destroyed"
  end
end
