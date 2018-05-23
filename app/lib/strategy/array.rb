module Strategy
  class Array
    def initialize(url = "http://openlibrary.org/search.json?q=the+lord+of+the+rings")
      @url = url
    end

    def calculate_price
      page.count_valid_elements
    end

    private
      def page
        Page::Json.new(Page::Fetcher.fetch(@url, JSON))
      end
  end
end
