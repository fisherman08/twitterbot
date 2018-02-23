module TwitterBot
  class Favoritor

    def initialize()
      @favs = []
      @keys = []
    end

    def regist_keys(keys)
      if keys.is_a? Array
        @keys += keys
      else
        @keys += [keys.to_s]
      end
    end

    def key_size
      @keys.size
    end

    def add(tweet)

      #TODO fav対象のツイートだけ追加する
      ((tweet.is_a? Array)? tweet : [tweet]).each do |t|
        @keys.each do |key|
          if t.text.match(/#{key}/)
            @favs << t
            break
          end
        end

      end
    end

    def << tweet
      self.add(tweet)
    end

    def favorites
      @favs.uniq
    end

  end


end
