class V1::LocationsController < ApplicationController
  def list
    locations = LocationGroup.locations_for_provider(country.panel_provider_id)
    json_response(locations: locations)
  end

  private
    def country
      country = Country.find_by(country_code: params[:country_code])
      country || raise(ActiveRecord::RecordNotFound, "Country code does not exist")
    end
end
