require 'test_helper'

class FiscalStatsControllerTest < ActionController::TestCase
  setup do
    @fiscal_stat = fiscal_stats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:fiscal_stats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create fiscal_stat" do
    assert_difference('FiscalStat.count') do
      post :create, fiscal_stat: {  }
    end

    assert_redirected_to fiscal_stat_path(assigns(:fiscal_stat))
  end

  test "should show fiscal_stat" do
    get :show, id: @fiscal_stat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @fiscal_stat
    assert_response :success
  end

  test "should update fiscal_stat" do
    patch :update, id: @fiscal_stat, fiscal_stat: {  }
    assert_redirected_to fiscal_stat_path(assigns(:fiscal_stat))
  end

  test "should destroy fiscal_stat" do
    assert_difference('FiscalStat.count', -1) do
      delete :destroy, id: @fiscal_stat
    end

    assert_redirected_to fiscal_stats_path
  end
end
