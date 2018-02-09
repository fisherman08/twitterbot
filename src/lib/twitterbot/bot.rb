require_relative './bot_config'
module TwitterBot
  class Bot
    def initialize(config_infos)
      @config = BotConfig.new(config_infos)

      @injections = []
    end

    def tweet
      'tweet'
    end

    ## TL監視ツイートを登録する
    def regist_injections

    end
  end
end
