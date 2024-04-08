json.extract! subreddit, :id, :title, :body, :user_id, :created_at, :updated_at
json.url subreddit_url(subreddit, format: :json)
