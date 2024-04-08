class AddPostIdToVotes < ActiveRecord::Migration[7.1]
  def change
    add_column :votes, :post_id, :integer
  end
end
