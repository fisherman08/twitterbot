module TwitterBot
  class BotConfig
    attr_reader :tokens
    def initialize(tokens)
      @tokens  = tokens
    end
  end
end
