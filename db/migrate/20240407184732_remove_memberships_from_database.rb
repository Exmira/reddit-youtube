class RemoveMembershipsFromDatabase < ActiveRecord::Migration[7.1]
  def change


    create_table :memberships do |t|
      t.integer :user_id
      t.string :subreddit_id

      t.timestamps
    end
  end
end
