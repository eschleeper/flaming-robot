require 'test_helper'

class CrittersControllerTest < ActionController::TestCase
  setup do
    @critter = critters(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:critters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create critter" do
    assert_difference('Critter.count') do
      post :create, critter: { name: @critter.name }
    end

    assert_redirected_to critter_path(assigns(:critter))
  end

  test "should show critter" do
    get :show, id: @critter
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @critter
    assert_response :success
  end

  test "should update critter" do
    patch :update, id: @critter, critter: { name: @critter.name }
    assert_redirected_to critter_path(assigns(:critter))
  end

  test "should destroy critter" do
    assert_difference('Critter.count', -1) do
      delete :destroy, id: @critter
    end

    assert_redirected_to critters_path
  end
end
