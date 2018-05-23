class GetPriceService
  STRATEGIES = [Strategy::Letter, Strategy::Array, Strategy::Node]

  attr_reader :country, :target_form, :locations, :errors

  def initialize(country, target_group_id, locations)
    @errors = {}
    @country = country
    @target_form = TargetForm.new(country.country_code, target_group_id)
    @locations = locations.map do |k, location|
      LocationForm.new(location[:id], location[:panel_size])
    end
  end

  def call
    raise(ExceptionHandler::InvalidParams, errors) unless valid?
    price = strategy.calculate_price
    { price: price }
  end

  private
    def price
    end

    def valid?
      validate_target_form
      validate_locations
      errors.blank?
    end

    def validate_target_form
      if @target_form.invalid?
        errors[:target] ||= []
        errors[:target] << @target_form.errors.full_messages
      end
    end

    def validate_locations
      locations.each do |location|
        if location.invalid?
          errors[:locations] ||= []
          errors[:locations] << location.errors.full_messages
        end
      end
    end

    def strategy
      strategy_class = Hash[PanelProvider.pluck(:id).zip(STRATEGIES)][country.panel_provider_id]
      strategy_class.new
    end
end
