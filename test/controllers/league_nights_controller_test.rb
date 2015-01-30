require 'test_helper'

class LeagueNightsControllerTest < ActionController::TestCase
  setup do
    @league_night = league_nights(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:league_nights)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create league_night" do
    assert_difference('LeagueNight.count') do
      post :create, league_night: { date: @league_night.date, league_id: @league_night.league_id, location_id: @league_night.location_id }
    end

    assert_redirected_to league_night_path(assigns(:league_night))
  end

  test "should show league_night" do
    get :show, id: @league_night
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @league_night
    assert_response :success
  end

  test "should update league_night" do
    patch :update, id: @league_night, league_night: { date: @league_night.date, league_id: @league_night.league_id, location_id: @league_night.location_id }
    assert_redirected_to league_night_path(assigns(:league_night))
  end

  test "should destroy league_night" do
    assert_difference('LeagueNight.count', -1) do
      delete :destroy, id: @league_night
    end

    assert_redirected_to league_nights_path
  end
end
