class NokogiriAdapter
  def self.parse(content)
    Nokogiri::HTML(content)
  end
end
