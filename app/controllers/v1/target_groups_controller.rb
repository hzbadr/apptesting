class V1::TargetGroupsController < ApplicationController
  include SetCountry

  def list
    target_groups = TargetGroup.for_provider(country.panel_provider_id)
    json_response(target_groups: target_groups)
  end
end
