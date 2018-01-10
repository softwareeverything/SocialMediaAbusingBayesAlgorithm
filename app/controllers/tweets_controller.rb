class TweetsController < ApplicationController
    before_action :UserAuthenticatedControl

    def UserAuthenticatedControl
        redirect_to root_path unless current_user
    end

    def index
        @page = (params[:page].nil?)?1:params[:page].to_i
        @TweetCountPerPage=5

        @tweets = current_user.twitter.home_timeline(:page=>@page, :count=>@TweetCountPerPage)

        @kelimeads = Kelimead.all
    end

    def tweetlerim
        @page = (params[:page].nil?)?1:params[:page].to_i
        @TweetCountPerPage=5

        @tweets = current_user.twitter.user_timeline(:page=>@page, :count=>@TweetCountPerPage, :exclude_replies=>true)
    end

    def show
        redirect_to tweets_url if params[:field].nil?
        @tweet = current_user.twitter.status(params[:field])
        @geriUrl = (params[:donusUrl].nil?)?root_url: params[:donusUrl]
    end

    def new
        if params[:body].nil?
            render 'new'
        else
            respond_to do |format|
                if current_user.twitter.update(params[:body])
                    format.html { redirect_to root_url+'tweets', notice: 'Tweetiniz başarılı bir şekilde atıldı...' }
                else
                    format.html { render :new }
                end
            end
        end
    end

    def update
        redirect_to tweets_url
    end

    def destroy
        current_user.twitter.destroy_tweet(params[:field])
        respond_to do |format|
          format.html { redirect_to root_url+'tweets', notice: 'Tweet was successfully destroyed.' }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:body)
    end
end