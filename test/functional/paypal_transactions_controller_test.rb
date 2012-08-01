require 'test_helper'

class PaypalTransactionsControllerTest < ActionController::TestCase
  setup do
    @paypal_transaction = paypal_transactions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:paypal_transactions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create paypal_transaction" do
    assert_difference('PaypalTransaction.count') do
      post :create, :paypal_transaction => @paypal_transaction.attributes
    end

    assert_redirected_to paypal_transaction_path(assigns(:paypal_transaction))
  end

  test "should show paypal_transaction" do
    get :show, :id => @paypal_transaction.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @paypal_transaction.to_param
    assert_response :success
  end

  test "should update paypal_transaction" do
    put :update, :id => @paypal_transaction.to_param, :paypal_transaction => @paypal_transaction.attributes
    assert_redirected_to paypal_transaction_path(assigns(:paypal_transaction))
  end

  test "should destroy paypal_transaction" do
    assert_difference('PaypalTransaction.count', -1) do
      delete :destroy, :id => @paypal_transaction.to_param
    end

    assert_redirected_to paypal_transactions_path
  end
end
