module Page
  class Json
    MIN_ELEMENTS_COUNT = 10

    def initialize(page, min_elements_count = MIN_ELEMENTS_COUNT)
      @page = page
      @min_elements_count = min_elements_count
    end

    def count_valid_elements
      @page["docs"].map { |object| elements_count_for_object(object) }.sum
    end

    private
      def valid_element(element)
        element.is_a?(Array) && element.count > @min_elements_count
      end

      def elements_count_for_object(object)
        object.select do |k, v|
          valid_element(v)
        end.keys.count
      end
  end
end
