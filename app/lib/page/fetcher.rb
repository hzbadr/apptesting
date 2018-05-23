require 'open-uri'

module Page
  class Fetcher
    def self.fetch(url, wrapper = NokogiriAdapter)
      wrapper.parse(open(url).read)
    end
  end
end
