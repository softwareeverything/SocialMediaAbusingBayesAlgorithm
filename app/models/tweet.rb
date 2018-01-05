class Tweet < ApplicationRecord
    belongs_to :user

    validates :user_id, :body, presence: true

    before_create :post_to_twitter
    before_destroy :post_destroy_twitter

    def post_to_twitter
        user.twitter.update(body)
    end

    def post_destroy_twitter
        user.twitter.destroy_tweet
    end
end