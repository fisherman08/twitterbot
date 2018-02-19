module TwitterBot
  class Favoritor

    def initialize()
      @favs = []
    end


    def add(tweet)
      @favs << tweet
    end

    def << tweet
      self.add(tweet)
    end

    def favorites
      @favs.uniq
    end

  end


end
