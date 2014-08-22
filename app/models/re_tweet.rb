class ReTweet < ActiveRecord::Base
  
  validates :tweet_id, uniqueness: true
  after_create :yo_me
  
  def self.search_billy_goat
    $twitter.user_timeline("Cheezborger", {:include_rts => false}).each do |tweet|
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :retweet_text => tweet.text,
        :did_retweet => false,
        :tweet_as => 2
      })
    end
  end
  
  def self.search_twitter
    
    
    $twitter.search("#wheresmysushi OR #wheresmyburrito OR #wheresmyburger OR #wheresmycheeseburger OR #wheresmypizza OR #wheresmytaco OR #cheeseburger OR  #doublecheeseburger OR  #triplecheeseburger OR #frenchfries OR #cocacola -rt", :result_type => "recent").take(10).each do |tweet|
      
      tweet_as = ( tweet.text.include? "#wheresmy" ) ? 1 : 2
      if tweet_as == 1
        thing = tweet.text.downcase.match(/#wheresmy([A-z]*)/)[1]
        retweet_text = "#{self.message_choices(thing.downcase)}http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name} #{tweet.text}"
      else
        if tweet.text.downcase.include? "#triplecheeseburger"
          retweet_text = "Cheeseborger, cheeseborger, cheeseborger! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#doublecheeseburger"
          retweet_text = "Cheeseborger, cheeseborger! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#coke"
          retweet_text = "No Coke! Pepsi! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#fries"
          retweet_text = "No fries! Chip! RT @#{tweet.user.screen_name} #{tweet.text}"
        else
          retweet_text = "Cheeseborger! RT @#{tweet.user.screen_name} #{tweet.text}"
        end
        
      end
      
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :retweet_text => self.twitter_limit(retweet_text),
        :did_retweet => false,
        :tweet_as => tweet_as
      })
      
    end
  end
  
  def send_retweet
    if !self.did_retweet
      if self.tweet_as == 2
        if self.tweeter == "Cheezborger"
          $cheeseborger_twitter.retweet(self.tweet_id)
        else
          $cheeseborger_twitter.update(self.retweet_text)
        end
      else
        $twitter.update(self.retweet_text)
      end
      self.update_column(:did_retweet, true)
    end
  end
  
  private
  
    def self.twitter_limit(tweet)
      return ActionController::Base.helpers.sanitize(tweet, :tags=>[]).truncate(140, :separator => " ").html_safe
    end
    
    def yo_me
      if self.tweet_as == 2
        
        if !self.did_retweet
          if self.tweeter == "Cheezborger"
            $cheeseborger_twitter.retweet(self.tweet_id)
          else
            $cheeseborger_twitter.update(self.retweet_text.to_str)
          end
          self.update_column(:did_retweet, true)
        end
        
      else
        require "net/http"
        require "uri"
        
        uri = URI.parse("http://api.justyo.co/yo/")
        
        http = Net::HTTP.new(uri.host, uri.port)
        
        request = Net::HTTP::Post.new(uri.request_uri)
        request.set_form_data({"api_token" => ENV['yo_api_key'], "username" => ENV['yo_username'], "link" => "#{ENV['base_url']}#{Rails.application.routes.url_helpers.re_tweet_path(:id => self.id)}"})
        
        http.request(request)
      end
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
