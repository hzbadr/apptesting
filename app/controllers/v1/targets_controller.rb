class V1::TargetsController < ApplicationController
  include SetCountry

  STRATEGIES = [Strategy::Letter, Strategy::Array, Strategy::Node]

  def evaluate
    if target.valid?
      price = strategy.calculate_price
      json_response(price: price)
    else
      json_response({ errors: target.errors.full_messages }, :unprocessable_entity)
    end
  end

  private
    def permitted_params
      @permitted ||= params.permit(:country_code, :target_group_id,
                                  locations: [:id, :panel_size])
    end

    def target
      @target ||= TargetForm.new(permitted_params[:country_code],
                                 permitted_params[:target_group_id],
                                 permitted_params[:locations].to_h)
    end

    def strategy
      strategy_class = Hash[PanelProvider.pluck(:id).zip(STRATEGIES)][country.panel_provider_id]
      strategy_class.new
    end
end
