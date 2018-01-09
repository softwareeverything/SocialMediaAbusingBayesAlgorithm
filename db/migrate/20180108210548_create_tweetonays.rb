class CreateTweetonays < ActiveRecord::Migration[5.1]
  def up
    create_table :tweetonays do |t|
      t.string :tweet

      t.timestamps
    end
  end

  def down
    drop_table :tweetonays
  end
end
