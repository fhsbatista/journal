class BodyMetricsController < ApplicationController
  before_action :authenticate_user!

  def create
    @body_metric = BodyMetric.new(body_metric_params)

    if @body_metric.save
      render json: @body_metric, status: :created
    else
      render json: @body_metric.errors, status: :unprocessable_entity
    end
  end

  # GET /body_metrics
  def index
    @body_metrics = BodyMetric.all

    render json: @body_metrics
  end

  private
    def body_metric_params
      params.require(:body_metric).permit(:date, :weight, :bf, :muscle_weight)
    end
end
