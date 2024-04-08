json.extract! membership, :id, :user_id, :subreddit_id, :created_at, :updated_at
json.url membership_url(membership, format: :json)
