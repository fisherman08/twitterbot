require_relative './bot_config'
require_relative './inspector'
module TwitterBot
  class Bot
    def initialize(config_infos)
      @config = BotConfig.new(config_infos)
      @client = nil
      @inspector = Inspector.new

      @tweets = []
    end

    def tweet
      'tweet'
    end

    def regist_inspection(type, key, text)
      @inspector.regist(type, key, text)
    end

    def inspect(raw_tweets)
      @tweets = @inspector.inspect(raw_tweets)
    end

    ## TL監視ツイートを登録する
    def regist_injections

    end
  end
end
