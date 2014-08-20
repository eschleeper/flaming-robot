class ReTweet < ActiveRecord::Base
  
  validates :tweet_id, uniqueness: true
  after_create :yo_me
  
  def self.search_twitter
    
    
    $twitter.search("#wheresmysushi OR #wheresmyburrito OR #wheresmyburger OR #wheresmycheeseburger OR #wheresmypizza -rt", :result_type => "recent", :lang => "en").take(10).each do |tweet|
      thing = tweet.text.downcase.match(/#wheresmy([A-z]*)/)[1]
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :retweet_text => "#{self.message_choices(thing.downcase)}http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name}: #{tweet.text}",
        :did_retweet => false
      })
    end
  end
  
  def send_retweet
    if !self.did_retweet
      $twitter.update(self.retweet_text)
      self.update_column(:did_retweet => true)
    end
  end
  
  private
    def yo_me
      require "net/http"
      require "uri"
      
      uri = URI.parse("http://api.justyo.co/yo/")
      
      http = Net::HTTP.new(uri.host, uri.port)
      
      request = Net::HTTP::Post.new(uri.request_uri)
      request.set_form_data({"api_token" => ENV['yo_api_key'], "username" => ENV['yo_username'], "link" => "#{ENV['base_url']}#{Rails.application.routes.url_helpers.re_tweet_path(:id => self.id)}"})
      
      http.request(request)
    end
    
    def self.message_choices(thing)
      messages = [
        self.make_retweet_text(thing),
        "I got your #{thing} here: ",
        "Ask and you shall receive "
      ].sample
    end
  
    def self.make_retweet_text(thing)
      case thing
      when "cheeseburger"
        return "Cheese borger, cheese borger, cheese borger! "
      when "burger"
        return "Mmmm burgers... "
      when "burrito"
        return "Tengo tu burrito aqui "
      when "sushi"
        return "Looking for some sushi? "
      when "pizza"
        return "I'm the moon, hitting your eye... "
      else
        return "I got your #{thing} here: "
      end
    end
  
end
