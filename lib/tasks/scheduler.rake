namespace :twitter do
  desc "search twitter"
  task search: :environment do
    ReTweet.search_twitter
  end

end
