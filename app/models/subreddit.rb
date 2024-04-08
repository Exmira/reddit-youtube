class Subreddit < ApplicationRecord

    extend FriendlyId
    friendly_id :title, use: :slugged

    has_many :posts
    has_many :memberships
    belongs_to :user
    
end
