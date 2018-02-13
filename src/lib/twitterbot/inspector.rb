require_relative './tweet'

module TwitterBot
  class Inspector
    attr_reader :inspections

    def initialize
      @inspections = []
    end

    def regist(type, key, text)
      @inspections << {type: type, key: key, text: text} if type == :injection
    end

    def inspect(raw_tweets)
      result = []
      raw_tweets.each do |raw_tweet|
        @inspections.each do |inspection|
          if inspection[:type] == :injection
            result += inspect_injection(raw_tweet, inspection[:key], inspection[:text])
          end
        end
      end
      result
    end

    private
    def inspect_injection(raw_tweet, key, reply_text)
      result = []
      text        = raw_tweet.text
      in_reply_to = raw_tweet.in_reply_to_status_id
      user        = raw_tweet.user

      unless text =~ /#{key}/ && in_reply_to == nil
        return result
      end

      result << Tweet.new("@#{user.screen_name} #{reply_text}")
    end
  end
end