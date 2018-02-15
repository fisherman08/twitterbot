require_relative './bot_config'
require_relative './inspector'
require 'twitter'
require 'yaml'

module TwitterBot
  class Bot
    def initialize(config_infos)
      @config    = BotConfig.new(config_infos)
      @inspector = Inspector.new

      @client   = nil
      @timeline = nil
      @tweets   = []
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
      return @client if @client

      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = @config.tokens['consumer_key']
        config.consumer_secret     = @config.tokens['consumer_secret']
        config.access_token        = @config.tokens['access_token']
        config.access_token_secret = @config.tokens['access_token_secret']
      end

    end

    def home_timeline
      return @timeline if @timeline

      result         = []
      client         = twitter_client
      user           = client.user
      last_status_id = last_status

      client.home_timeline(since_id: last_status_id, include_rts: false).each do |raw_tweet|
        # 自分のtweetは無視
        next if raw_tweet.user.id == user.id
        # RTは無視
        next unless raw_tweet.retweeted_status.nil?

        result << raw_tweet
      end
      @timeline = result
    end

    # 最後に取得したツイートのIDを保存する
    def save_status(status_id)
      file = File.open(status_file_name, 'w' )
      YAML.dump({last_status: status_id}, file)
      file.close
    end

    # 最後の取得したツイートのIDを取得する
    def last_status
      file = status_file_name
      return nil unless File.exist? file

      data = YAML.load_file(status_file_name)
      data[:last_status]
    end

    # 取得履歴を消す
    def reset_status
      file = status_file_name
      File.delete(file) if File.exist? file
    end

    private
    # 最後に取得したツイートのファイル名を取得
    def status_file_name
      user_id = twitter_client.user.id
      dir = Dir.home + '/.twitterbot'
      FileUtils.makedirs dir unless Dir.exist? dir

      "#{dir}/#{user_id}.yml"
    end


  end
end
