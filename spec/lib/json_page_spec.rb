require_relative '../../lib/json_page'

RSpec.describe JsonPage do
  let (:page) {
    {
      "docs" => [
        {
        key1: (1..11).to_a,
        key2: (1..5).to_a,
        key3: "Hello World",
        key4: [],
        key5: nil,
        key6: 0,
        key7: (1..11).to_a
      },
      {
        key1: (1..11).to_a,
        key2: (1..5).to_a,
        key3: "Hello World",
        key4: [],
        key5: nil,
        key6: 0,
        key7: (1..11).to_a,
        key8: (1..10).to_a
      }]
    }
  }
  let (:json_page_default_count) { JsonPage.new(page) }
  let (:json_page_custom_count) { JsonPage.new(page, 0) }

  it "count keys having more than 10 elements as default value" do
    expect(json_page_default_count.count_valid_elements).to eq(4)
  end
  it "count keys having more than 0 elements" do
    expect(json_page_custom_count.count_valid_elements).to eq(7)
  end
end
