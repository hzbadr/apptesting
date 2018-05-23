class ArrayStrategy
  def initialize(url = "http://openlibrary.org/search.json?q=the+lord+of+the+rings")
    @url = url
  end

  def calculate_price
    page.count_valid_elements
  end

  private
    def page
      Page::Json.new(PageFetcher.fetch(@url, JSON))
    end
end
