class TargetGroup < ApplicationRecord
  belongs_to :parent, class_name: "TargetGroup", foreign_key: "parent_id", optional: true
  belongs_to :panel_provider, optional: true

  has_many :children, foreign_key: "parent_id"

  def self.roots
    where(parent_id: nil)
  end

  def self.for_provider(provider_id)
    where(panel_provider_id: provider_id)
  end
end
