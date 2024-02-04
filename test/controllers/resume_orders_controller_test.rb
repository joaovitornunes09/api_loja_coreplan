require "test_helper"

class ResumeOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resume_order = resume_orders(:one)
  end

  test "should get index" do
    get resume_orders_url, as: :json
    assert_response :success
  end

  test "should create resume_order" do
    assert_difference("ResumeOrder.count") do
      post resume_orders_url, params: { resume_order: { order_id: @resume_order.order_id, total_value: @resume_order.total_value, total_value_with_discounts: @resume_order.total_value_with_discounts } }, as: :json
    end

    assert_response :created
  end

  test "should show resume_order" do
    get resume_order_url(@resume_order), as: :json
    assert_response :success
  end

  test "should update resume_order" do
    patch resume_order_url(@resume_order), params: { resume_order: { order_id: @resume_order.order_id, total_value: @resume_order.total_value, total_value_with_discounts: @resume_order.total_value_with_discounts } }, as: :json
    assert_response :success
  end

  test "should destroy resume_order" do
    assert_difference("ResumeOrder.count", -1) do
      delete resume_order_url(@resume_order), as: :json
    end

    assert_response :no_content
  end
end
