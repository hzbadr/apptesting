require_relative '../../lib/html_page'

RSpec.describe HtmlPage do

  it "counts letters" do
    page = double('page')
    text = double('text')
    allow(text).to receive("text").and_return(" abc a 'aaa haha")
    allow(page).to receive("at").and_return(text)
    html_page = HtmlPage.new(page)
    expect(html_page.count_letter("a")).to eq(7)
  end

  it "counts HTML nodes" do
    require 'nokogiri'
    content = <<-HTML
      <html>
        <body>
          <div></div>
          <div>
            <div>
              <div></div>
            </div>
          </div>
        </body>
      </html>
    HTML
    html = Nokogiri::HTML(content)
    page = HtmlPage.new(html)
    expect(page.count_nodes).to eq(6)
  end
end


class HtmlPageMock
  def initialize(page)
    @page = page
  end

  # count is not 100% accurate, some data is fetched as AJAX!
  def count_letter(letter)
    page_text.count(letter)
  end

  def count_nodes
    # dosomethinghere
  end

  private
    def page_text
      page.at('body').text
    end
end
