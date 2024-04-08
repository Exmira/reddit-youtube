class AddUserIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :user_id, :integer
    remove_column :votes, :subreddits_id, :integer
    remove_column :votes, :users_id, :integer
  end
end
