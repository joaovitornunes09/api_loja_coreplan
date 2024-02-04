require "test_helper"

class OffersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @offer = offers(:one)
  end

  test "should get index" do
    get offers_url, as: :json
    assert_response :success
  end

  test "should create offer" do
    assert_difference("Offer.count") do
      post offers_url, params: { offer: { description: @offer.description, discount_percent: @offer.discount_percent, name: @offer.name, product_id: @offer.product_id } }, as: :json
    end

    assert_response :created
  end

  test "should show offer" do
    get offer_url(@offer), as: :json
    assert_response :success
  end

  test "should update offer" do
    patch offer_url(@offer), params: { offer: { description: @offer.description, discount_percent: @offer.discount_percent, name: @offer.name, product_id: @offer.product_id } }, as: :json
    assert_response :success
  end

  test "should destroy offer" do
    assert_difference("Offer.count", -1) do
      delete offer_url(@offer), as: :json
    end

    assert_response :no_content
  end
end
