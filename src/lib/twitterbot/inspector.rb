module TwitterBot
  class Inspector
    def initialize
      @inspections = []
    end

    def regist(type, key, text)
      @inspections << {key: key, text: text}
    end

    def inspect(raw_tweets)
      raw_tweets.each do |raw_tweet|
        
      end
    end
  end
end
