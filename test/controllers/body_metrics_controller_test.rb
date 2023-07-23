require "test_helper"

class BodyMetricsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @body_metric = body_metrics(:one)
  end

  test "should get index" do
    get body_metrics_url, as: :json
    assert_response :success
  end

  test "should create body_metric" do
    assert_difference("BodyMetric.count") do
      post body_metrics_url, params: { body_metric: { bf: @body_metric.bf, date: @body_metric.date, muscle_weight: @body_metric.muscle_weight, weight: @body_metric.weight } }, as: :json
    end

    assert_response :created
  end

  test "should show body_metric" do
    get body_metric_url(@body_metric), as: :json
    assert_response :success
  end

  test "should update body_metric" do
    patch body_metric_url(@body_metric), params: { body_metric: { bf: @body_metric.bf, date: @body_metric.date, muscle_weight: @body_metric.muscle_weight, weight: @body_metric.weight } }, as: :json
    assert_response :success
  end

  test "should destroy body_metric" do
    assert_difference("BodyMetric.count", -1) do
      delete body_metric_url(@body_metric), as: :json
    end

    assert_response :no_content
  end
end
