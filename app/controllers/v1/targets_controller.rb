class V1::TargetsController < ApplicationController
  STRATEGIES = [LetterStrategy, ArrayStrategy, NodeStrategy]

  def evaluate
    target = TargetForm.new(permitted_params[:country_code],
                            permitted_params[:target_group_id],
                            permitted_params[:locations].to_h)
    if target.valid?
      price = strategy.calculate_price
      json_response(price: price)
    else
      json_response(errors: target.errors.full_messages)
    end
  end

  private
    def permitted_params
      @permitted ||= params.permit(:country_code, :target_group_id,
                                  locations: [:id, :panel_size])
    end

    def target_group
      TargetGroup.find(permitted_params[:target_group_id])
    end

    def strategy
      strategy_class = Hash[PanelProvider.pluck(:id).zip(STRATEGIES)][target_group.panel_provider_id]
      strategy_class.new
    end
end
