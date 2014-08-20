class ReTweetsController < ApplicationController
  before_action :set_re_tweet, only: [:show, :edit, :update, :destroy, :send_retweet]

  # GET /re_tweets
  # GET /re_tweets.json
  def index
    @re_tweets = ReTweet.all
  end

  # GET /re_tweets/1
  # GET /re_tweets/1.json
  def show
  end

  # GET /re_tweets/new
  def new
    @re_tweet = ReTweet.new
  end

  # GET /re_tweets/1/edit
  def edit
  end

  # POST /re_tweets
  # POST /re_tweets.json
  def create
    @re_tweet = ReTweet.new(re_tweet_params)

    respond_to do |format|
      if @re_tweet.save
        format.html { redirect_to @re_tweet, notice: 'Re tweet was successfully created.' }
        format.json { render :show, status: :created, location: @re_tweet }
      else
        format.html { render :new }
        format.json { render json: @re_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /re_tweets/1
  # PATCH/PUT /re_tweets/1.json
  def update
    respond_to do |format|
      if @re_tweet.update(re_tweet_params)
        format.html { redirect_to @re_tweet, notice: 'Re tweet was successfully updated.' }
        format.json { render :show, status: :ok, location: @re_tweet }
      else
        format.html { render :edit }
        format.json { render json: @re_tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /re_tweets/1
  # DELETE /re_tweets/1.json
  def destroy
    @re_tweet.destroy
    respond_to do |format|
      format.html { redirect_to re_tweets_url, notice: 'Re tweet was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def search
    ReTweet.search_twitter
    redirect_to action: "index"
  end
  
  def send_retweet
    @re_tweet.send_retweet
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_re_tweet
      @re_tweet = ReTweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def re_tweet_params
      params.require(:re_tweet).permit(:tweet_id, :tweeter, :tweet_text, :retweet_text, :did_retweet)
    end
end
