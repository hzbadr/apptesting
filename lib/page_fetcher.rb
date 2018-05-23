require 'open-uri'

class PageFetcher
  def self.fetch(url, wrapper = NokogiriAdapter)
    wrapper.parse(open(url).read)
  end
end
