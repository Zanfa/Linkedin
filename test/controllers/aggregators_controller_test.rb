require 'test_helper'

class AggregatorsControllerTest < ActionController::TestCase
  setup do
    @aggregator = aggregators(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:aggregators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create aggregator" do
    assert_difference('Aggregator.count') do
      post :create, aggregator: { invite_key: @aggregator.invite_key, name: @aggregator.name, owner_id: @aggregator.owner_id }
    end

    assert_redirected_to aggregator_path(assigns(:aggregator))
  end

  test "should show aggregator" do
    get :show, id: @aggregator
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @aggregator
    assert_response :success
  end

  test "should update aggregator" do
    patch :update, id: @aggregator, aggregator: { invite_key: @aggregator.invite_key, name: @aggregator.name, owner_id: @aggregator.owner_id }
    assert_redirected_to aggregator_path(assigns(:aggregator))
  end

  test "should destroy aggregator" do
    assert_difference('Aggregator.count', -1) do
      delete :destroy, id: @aggregator
    end

    assert_redirected_to aggregators_path
  end
end
