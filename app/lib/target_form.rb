class TargetForm
  include ActiveModel::Model

  attr_reader :country_code, :target_group_id, :locations

  validates :country_code, :target_group_id, presence: true
  validates :target_group_id, numericality: { only_integer: true }

  def initialize(country_code, target_group_id)
    @country_code = country_code
    @target_group_id = target_group_id
  end
end
