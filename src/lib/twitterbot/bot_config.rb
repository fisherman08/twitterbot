module TwitterBot
  class BotConfig
    attr_reader :user_id
    def initialize(user_id, tokens)
      @user_id = user_id
      @tokens  = tokens
    end
  end
end
