class TargetGroup < ApplicationRecord
  belongs_to :parent, class_name: "TargetGroup"
  belongs_to :panel_provider

  has_many :children, foreign_key: "parent_id"
end
