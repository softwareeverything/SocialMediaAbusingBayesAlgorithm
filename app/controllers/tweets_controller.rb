class TweetsController < ApplicationController
    before_action :UserAuthenticatedControl

    def UserAuthenticatedControl
        redirect_to root_path unless current_user
    end

    # GET /tweets
    # GET /tweets.json
    def index
        @tweets = current_user.twitter.user_timeline
    end

    # GET /tweets/1
    # GET /tweets/1.json
    def show
    end

    # GET /tweets/new
    def new
        @tweet = Tweet.new
    end

    # GET /tweets/1/edit
    def edit
    end

    # POST /tweets
    # POST /tweets.json
    def create
        respond_to do |format|
            if current_user.twitter.update(params[:body])
                format.html { redirect_to @tweet, notice: 'Tweet was successfully created.' }
                format.json { render :show, status: :created, location: @tweet }
            else
                format.html { render :new }
                format.json { render json: @tweet.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /tweets/1
    # PATCH/PUT /tweets/1.json
    def update
        respond_to do |format|
            if current_user.twitter.update(params[:body])
                format.html { redirect_to @tweet, notice: 'Tweet was successfully updated.' }
                format.json { render :show, status: :ok, location: @tweet }
            else
                format.html { render :edit }
                format.json { render json: @tweet.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /tweets/1
    # DELETE /tweets/1.json
    def destroy
        current_user.twitter.destroy_tweet(params[:id])
        respond_to do |format|
          format.html { redirect_to tweets_url, notice: 'Tweet was successfully destroyed.' }
          format.json { head :no_content }
        end
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:body)
    end
    end