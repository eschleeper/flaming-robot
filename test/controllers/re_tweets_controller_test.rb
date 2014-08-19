require 'test_helper'

class ReTweetsControllerTest < ActionController::TestCase
  setup do
    @re_tweet = re_tweets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:re_tweets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create re_tweet" do
    assert_difference('ReTweet.count') do
      post :create, re_tweet: { did_retweet: @re_tweet.did_retweet, retweet_text: @re_tweet.retweet_text, tweet_id: @re_tweet.tweet_id, tweet_text: @re_tweet.tweet_text, tweeter: @re_tweet.tweeter }
    end

    assert_redirected_to re_tweet_path(assigns(:re_tweet))
  end

  test "should show re_tweet" do
    get :show, id: @re_tweet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @re_tweet
    assert_response :success
  end

  test "should update re_tweet" do
    patch :update, id: @re_tweet, re_tweet: { did_retweet: @re_tweet.did_retweet, retweet_text: @re_tweet.retweet_text, tweet_id: @re_tweet.tweet_id, tweet_text: @re_tweet.tweet_text, tweeter: @re_tweet.tweeter }
    assert_redirected_to re_tweet_path(assigns(:re_tweet))
  end

  test "should destroy re_tweet" do
    assert_difference('ReTweet.count', -1) do
      delete :destroy, id: @re_tweet
    end

    assert_redirected_to re_tweets_path
  end
end
