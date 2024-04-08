class CreateVotes < ActiveRecord::Migration[7.1]
  def change
    create_table :votes do |t|
      t.references :users, null: false, foreign_key: true
      t.references :subreddits, null: false, foreign_key: true
      t.integer :value

      t.timestamps
    end
  end
end
