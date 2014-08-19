class ReTweet < ActiveRecord::Base
  
  validates :tweet_id, uniqueness: true
  before_create :yo_me
  
  def self.search_twitter
    $twitter.search("#wheresmysushi OR #wheresmyburrito OR #wheresmyburger OR #wheresmycheeseburger OR #wheresmypizza -rt", :result_type => "recent", :lang => "en").take(10).each do |tweet|
      thing = tweet.text.downcase.match(/#wheresmy([A-z]*)/)[1]
      puts "I got your #{thing} here: http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name}: #{tweet.text}"
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :retweet_text => "I got your #{thing} here: http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name}: #{tweet.text}",
        :did_retweet => false
      })
    end
  end
  
  private
    def self.yo_me
      require "net/http"
      require "uri"
      
      uri = URI.parse("http://api.justyo.co/yo/")
      
      # Full control
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({"api_token" => Rails.configuration.yo_api_key, "username" => Rails.configuration.yo_username})
       
      response = http.request(request)
      puts response.inspect
    end
  
end
