class LaunchesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  before_action :set_launch, only: %i[show edit update destroy]

  def create
    launch_service = LaunchService.new(request, params)
    if launch_service.authenticate_launch
      launch_service.create_graph
      set_current_enrollment(launch_service.enrollment)

      redirect_to resource_path(launch_service.resource)
    else
      redirect_to "/landing", notice: "Unauthorized!"
    end
  end

  def xml_config
    respond_to do |format|
      format.xml do
        tool_config = IMS::LTI::ToolConfig.new(
          title: "firstdraft #{Rails.application.class.module_parent.to_s.underscore}",
          launch_url: launch_url,
        )

        tool_config.description = "This LTI Tool provides some good vibes!"

        render xml: tool_config.to_xml
      end
    end
  end

  private

  def set_launch
    @launch = Launch.find(params[:id])
  end

  def launch_params
    params.require(:launch).permit(:context_id, :tool_consumer_id, :user_id,
                                   :enrollment_id, :resource_id, :payload)
  end
end
