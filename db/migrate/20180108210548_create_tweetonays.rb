class CreateTweetonays < ActiveRecord::Migration[5.1]
  def up
    create_table :tweetonays do |t|
      t.references :tweet, foreign_key: true
      t.string :icerik
      t.timestamps
    end
  end

  def down
    drop_table :tweetonays
  end
end