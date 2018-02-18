module TwitterBot
  class Favoritor

    def initialize()
      @favs = []
    end


    def add(status_id)
      @favs << status_id
    end

    def << status_id
      self.add(status_id)
    end

    def favorites
      @favs.uniq
    end

  end


end
