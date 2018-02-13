require_relative './bot_config'
require_relative './inspector'
require 'twitter'

module TwitterBot
  class Bot
    def initialize(config_infos)
      @config    = BotConfig.new(config_infos)
      @inspector = Inspector.new

      @tweets = []
    end

    def tweet
      client = twitter_client
      count = 0
      @tweets.each do |tweet|
        client.update(tweet.tweet, in_reply_to_status_id: tweet.in_reply_to)
        count += 1
      end
      count
    end

    def regist_inspection(inspections)
      inspections.each do |inspection|
        @inspector.regist(:injection, inspection['key'], inspection['text'])
      end
    end

    def inspect
      @tweets = @inspector.inspect(home_timeline)
    end

    def twitter_client
      Twitter::REST::Client.new do |config|
        config.consumer_key        = @config.tokens['consumer_key']
        config.consumer_secret     = @config.tokens['consumer_secret']
        config.access_token        = @config.tokens['access_token']
        config.access_token_secret = @config.tokens['access_token_secret']
      end
    end

    def home_timeline
      result = []
      client = twitter_client
      user   = client.user
      client.home_timeline.each do |raw_tweet|
        # 自分のtweetは無視
        next if raw_tweet.user.id == user.id
        # RTは無視
        next unless raw_tweet.retweeted_status.nil?

        result << raw_tweet
      end
      result
    end

  end
end
