module TwitterBot
  class Tweet

    def initialize(text: '', in_reply_to_status_id: nil)
      @text = text
      @in_reply_to_status_id = in_reply_to_status_id
    end


    def tweet
      @text
    end

    def in_reply_to
      @in_reply_to_status_id
    end

  end


end
