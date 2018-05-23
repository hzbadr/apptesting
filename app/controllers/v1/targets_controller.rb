class V1::TargetsController < ApplicationController
  include SetCountry

  def evaluate
    price_service = GetPriceService.new(country,
                                        permitted_params[:target_group_id],
                                        permitted_params[:locations].to_h)
    json_response(price_service.call)
  end

  private
    def permitted_params
      @permitted ||= params.permit(:country_code, :target_group_id,
                                  locations: [:id, :panel_size])
    end
end
