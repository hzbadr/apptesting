class V1::Public::LocationsController < ApplicationController
  include SetCountry

  def list
    locations = LocationGroup.locations_for_provider(country.panel_provider_id)
    json_response(locations: locations)
  end
end
