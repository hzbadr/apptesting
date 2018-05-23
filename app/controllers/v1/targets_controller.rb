class V1::TargetsController < ApplicationController
  def evaluate
    target = TargetForm.new(permitted_params[:country_code],
                            permitted_params[:target_group_id],
                            permitted_params[:locations].to_h)
    if target.valid?
      json_response(target: target, locations: target.locations)
    else
      json_response(errors: target.errors.full_messages)
    end
  end

  def permitted_params
    @permitted ||= params.permit(:country_code, :target_group_id,
                                 locations: [:id, :panel_size])
  end
end
