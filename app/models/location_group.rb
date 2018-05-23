class LocationGroup < ApplicationRecord
  #HZ: Why does locationgroup belong to country and provider??
  belongs_to :country
  belongs_to :panel_provider

  has_and_belongs_to_many :locations

  def self.locations_for_provider(provider_id)
    includes(:locations).
      where(panel_provider_id: provider_id).
      map(&:locations).flatten
  end
end
