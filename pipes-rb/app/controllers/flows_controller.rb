class FlowsController < ApplicationController
  def show
    @flow = Flow.find_by(flow_tag: params[:flow_tag])

    respond_to do |format|
      if @flow
        format.html { redirect_to @flow } 
        format.json { render json: { success: true, payload: @flow.payload } }
      else
        format.json { render json: { success: false, error: "flow not found" }, status: 404 }
      end
    end
  end

  def create
    @flow = Flow.create(flow_params)

    respond_to do |format|
      if @flow.save
        format.html { redirect_to @flow }
        format.json { render json: { success: true, id: @flow.id, flow_tag: @flow.flow_tag } }
      else
        format.html { redirect_to root_path }
        format.json { render json: { success: false, error: @flow.errors }, status: 404 }
      end
    end
  end

  private
  def flow_params
    params.require(:flow).permit(:user_id, :flow_tag, :flow_type, :payload)
  end
end
