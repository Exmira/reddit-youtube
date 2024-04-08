class AddSlugToSubreddits < ActiveRecord::Migration[7.1]
  def change
    add_column :subreddits, :slug, :string
    add_index :subreddits, :slug, unique: true
  end
end
