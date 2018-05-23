class TargetForm
  include ActiveModel::Model

  attr_reader :country_code, :target_group_id, :locations

  validates :country_code, :target_group_id, presence: true
  validates :target_group_id, numericality: { only_integer: true }

  validate :validate_locations

  def initialize(country_code, target_group_id, locations)
    @country_code = country_code
    @target_group_id = target_group_id

    @locations = locations.map do |k, location|
      LocationForm.new(location[:id], location[:panel_size])
    end
  end

  private
    def validate_locations
      locations.each do |location|
        errors.add(:locations, location.errors.full_messages) if location.invalid?
      end
    end
end

class LocationForm
  include ActiveModel::Model

  attr_reader :id, :panel_size

  validates :id, :panel_size, presence: true
  validates :id, :panel_size, numericality: { only_integer: true }

  def initialize(id, panel_size)
    @id = id
    @panel_size = panel_size
  end
end