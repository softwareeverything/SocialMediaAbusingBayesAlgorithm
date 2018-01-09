class AddUserToTweetonay < ActiveRecord::Migration[5.1]
  def up
    add_reference :tweetonays, :user, foreign_key: true
  end

  def down
    remove_reference :tweetonays, :user
  end
end
