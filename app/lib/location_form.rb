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
