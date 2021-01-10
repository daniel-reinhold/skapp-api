require 'test_helper'

class SheetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @sheet = sheets(:one)
  end

  test "should get index" do
    get sheets_url, as: :json
    assert_response :success
  end

  test "should create sheet" do
    assert_difference('Sheet.count') do
      post sheets_url, params: { sheet: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show sheet" do
    get sheet_url(@sheet), as: :json
    assert_response :success
  end

  test "should update sheet" do
    patch sheet_url(@sheet), params: { sheet: {  } }, as: :json
    assert_response 200
  end

  test "should destroy sheet" do
    assert_difference('Sheet.count', -1) do
      delete sheet_url(@sheet), as: :json
    end

    assert_response 204
  end
end
