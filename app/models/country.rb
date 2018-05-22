class Country < ApplicationRecord
  belongs_to :panel_provider

  def self.location_group_for(country_code)
    panel_provider_id = Country.find_by(country_code: country_code).panel_provider_id
    LocationGroup.find_by(panel_provider_id: panel_provider_id)
  end
end
