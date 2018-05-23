class HtmlPage
  def initialize(page)
    @page = page
  end

  # count is not 100% accurate, some HTML nodes are fetched using AJAX!
  def count_letter(letter)
    page_text.count(letter)
  end

  # count is not 100% accurate, some HTML nodes are fetched using AJAX!
  def count_nodes
    @page.xpath("//*").count
  end

  private
    def page_text
      @page.at('body').text
    end
end
