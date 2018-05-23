class PanelProvider < ApplicationRecord
  has_many :location_groups
  has_many :target_groups
end
