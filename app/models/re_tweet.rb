class ReTweet < ActiveRecord::Base
  
  validates :tweet_id, uniqueness: true
  after_create :yo_me
  
  def self.search_nerd_stuff
    $schleeper_twitter.search("#nodejs OR #rubyonrails OR #backbonejs OR #jquery OR #postgres OR #nginx OR #bootstrap -rt", :result_type => "popular").take(40).each do |tweet|
      self.create({
        :tweet_id => tweet.id,
        :tweeter => tweet.user.screen_name,
        :tweet_text => tweet.text,
        :did_retweet => false,
        :tweet_as => 3
      })
      
    end
    random_number = rand(1..1000)
    if random_number < 120
      thing_to_retweet = self.where(['created_at > ? AND did_retweet = ?', 8.hours.ago, false]).sample
      if random_number == 1
        retweet_text = "#{['What do you think', 'Hey','Hmm, I dont know'].sample}, @#{self.get_a_big_player}? #{question}"
      elsif thing_to_retweet
        retweet_text =  "#{phrase_for_schleep_bot} RT @#{thing_to_retweet.tweeter} #{thing_to_retweet.tweet_text}"
        thing_to_retweet.update_column(:did_retweet, true)
      else
        retweet_text = "#{phrase_for_schleep_bot}"
      end
      #puts retweet_text
      $schleeper_twitter.update(twitter_limit(retweet_text).to_str)
    end
  end
  
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
    
    
    $twitter.search("#wheresmysushi OR #wheresmyburrito OR #wheresmyburger OR #wheresmycheeseburger OR #wheresmypizza OR #wheresmysandwich  OR #wheresmyfrenchfries OR #wheresmytaco OR #cheeseburger OR  #doublecheeseburger OR  #triplecheeseburger OR #frenchfries OR #cocacola OR #cheezborger -rt", :result_type => "recent").take(30).each do |tweet|
      
      tweet_as = ( tweet.text.downcase.include? "#wheresmy" ) ? 1 : 2
      if tweet_as == 1
        thing = tweet.text.downcase.match(/#wheresmy([A-z]*)/)[1]
        retweet_text = "#{self.message_choices(thing.downcase)}http://bitchwher.es/#/my/#{thing} RT @#{tweet.user.screen_name} #{tweet.text}"
      else
        if tweet.text.downcase.include? "#triplecheeseburger"
          retweet_text = "Cheeseborger, cheeseborger, cheeseborger! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#doublecheeseburger"
          retweet_text = "Cheeseborger, cheeseborger! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#cocacola"
          retweet_text = "No Coke! Pepsi! RT @#{tweet.user.screen_name} #{tweet.text}"
        elsif tweet.text.downcase.include? "#frenchfries"
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
          self.do_the_tweet
        end
      else
        self.do_the_tweet
      end
      self.update_column(:did_retweet, true)
    end
  end
    
    def do_the_tweet
      if self.tweet_as == 1
        $twitter.update(self.retweet_text.to_str)
      elsif self.tweet_as == 2
        $cheeseborger_twitter.update(self.retweet_text.to_str)
      #else
      #  $schleeper_twitter.update(self.retweet_text.to_str)
      end
      #puts "sending #{self.retweet_text}"
    end
  
  private
  
    def self.phrase_for_schleep_bot
      [
        "#{start_statement_3} #{noun_for_schleep_bot(2).join()} the #{adjective_for_schleep_bot} #{noun_for_schleep_bot(1).first}. ##{noun_for_schleep_bot(4).join(' #')}",
        "#{start_statement_2} #{verbing_for_schleep_bot} #{maybe_hashtag(adjective_for_schleep_bot)} #{maybe_hashtag(noun_for_schleep_bot(2).join())}s, #{with_articles} #{maybe_hashtag(adjective_for_schleep_bot)} #{maybe_hashtag(noun_for_schleep_bot(1).first)}",
        "#{start_statement} #{maybe_hashtag(noun_for_schleep_bot(1).first)}s #{verbing_for_schleep_bot} #{maybe_hashtag(noun_for_schleep_bot(1).first)}s, #{do_transition} #{adjective_for_schleep_bot} #{maybe_hashtag(noun_for_schleep_bot(1).first)}s #{verbing_for_schleep_bot} #{with_articles} #{maybe_hashtag(noun_for_schleep_bot(1).first)}",
        question
      ].sample
    end
    
    def self.question
      "#{start_question} #{verb_for_schleep_bot} #{maybe_hashtag(noun_for_schleep_bot(1).first)} #{maybe_hashtag(noun_for_schleep_bot(1).first)}s #{with_articles} #{maybe_hashtag(noun_for_schleep_bot(2).join())}? ##{noun_for_schleep_bot(3).join(' #')}"
    end
    
    def self.start_statement_3
      [
        "Remember to always",
        "I like to make sure I",
        "It's best to",
        "First step:"
      ].sample
    end
    
    def self.start_question
      [
        "Anyone",
        "How do I",
        "Can I",
        "Should I"
      ].sample
    end
    
    def self.start_statement
      [
        "Right now, the trend is",
        "The future is",
        "So, today the"
      ].sample
    end
    
    def self.start_statement_2
      [
        "The most important part of the process, is",
        "My favorite part about being a programmer, is",
        "I am stuck",
        "Today I am"
      ].sample
    end
    
    def self.do_transition
      [
        "in the",
        "while a",
        "and",
        "so"
      ].sample
    end
    
    def self.with_articles
      ["in the",
      "in a",
      "for",
      "with"].sample
    end
    
    def self.adjective_for_schleep_bot
      [
        "enterprise level",
        "modern",
        "frontend",
        "node",
        "rails",
        "html5",
        "scalable",
        "github",
        "ninja",
        "legacy",
        "snappy",
        "agile",
        "blazing fast",
        "responsive",
        "MVC"
      ].sample
    end
    
    def self.verbing_for_schleep_bot
      [
        "deploying",
        "scaling",
        "compiling",
        "developing",
        "creating",
        "controlling",
        "scripting",
        "mastering",
        "caching"
      ].sample
    end
    
    def self.verb_for_schleep_bot
      [
        "run",
        "scale",
        "compile",
        "code",
        "design",
        "develop",
        "serve",
        "make"
      ].sample
    end
    
    def self.noun_for_schleep_bot(count)
      [
        "heroku",
        "cloud",
        "gem",
        "server",
        "git",
        "code",
        "css3",
        "jquery",
        "database",
        "sql",
        "cache",
        "url",
        "pushstate",
        "storedproc",
        "memcache",
        "mongo",
        "postgresql",
        "coldfusion",
        "backbone",
        "router",
        "model",
        "web",
        "view",
        "nginx",
        "java",
        "dev",
        "bootstrap",
        "workflow",
        "framework",
        "apache",
        "proxy",
        "ios",
        "android",
        "cordova",
        "xcode"
      ].sample(count)
    end
    
    def self.maybe_hashtag(words)
      [
        words,
        "##{words}"
      ].sample
    end
  
    def self.twitter_limit(tweet)
      return ActionController::Base.helpers.sanitize(tweet, :tags=>[]).truncate(140, :separator => " ").html_safe
    end
    
    def yo_me
      if self.tweet_as == 3
        
      else
        
        if !self.did_retweet
          if self.tweeter == "Cheezborger"
            $cheeseborger_twitter.retweet(self.tweet_id)
          else
            self.do_the_tweet
          end
          self.update_column(:did_retweet, true)
        end
        
      #else
      #  require "net/http"
      #  require "uri"
      #  
      #  uri = URI.parse("http://api.justyo.co/yo/")
      #  
      #  http = Net::HTTP.new(uri.host, uri.port)
      #  
      #  request = Net::HTTP::Post.new(uri.request_uri)
      #  request.set_form_data({"api_token" => ENV['yo_api_key'], "username" => ENV['yo_username'], "link" => "#{ENV['base_url']}#{Rails.application.routes.url_helpers.re_tweet_path(:id => self.id)}"})
      #  
      #  http.request(request)
      end
    end
    
    def self.message_choices(thing)
      messages = [
        self.make_retweet_text(thing),
        "I got your ##{thing} here: ",
        "Ask and you shall receive ",
        "BOOM!! ##{thing.titleize}! "
      ].sample
    end
  
    def self.make_retweet_text(thing)
      case thing
      when "cheeseburger"
        return "Cheezborger, #cheezborger, cheezborger! "
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
    
    def self.get_a_big_player
      [
        "dhh",
        "addyosmani",
        "paul_irish",
        "meyerweb",
        "chriscoyier",
        "zeldman"
      ].sample
    end
  
end
