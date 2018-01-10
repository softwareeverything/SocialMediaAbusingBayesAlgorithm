class CreateTweets < ActiveRecord::Migration[5.1]
  def up
    create_table :tweets do |t|
      t.references :user, foreign_key: true
      t.column :tweetid, :bigint, unique: true, null: false
      t.column :tehdit, :smallint
      t.column :kufur, :smallint
      t.column :aldatma, :smallint
      t.column :siddet, :smallint
    end
  end

  def down
    drop_table :tweets
  end
end