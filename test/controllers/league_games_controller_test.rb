require 'test_helper'

class LeagueGamesControllerTest < ActionController::TestCase
  setup do
    @league_game = league_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:league_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create league_game" do
    assert_difference('LeagueGame.count') do
      post :create, league_game: {  }
    end

    assert_redirected_to league_game_path(assigns(:league_game))
  end

  test "should show league_game" do
    get :show, id: @league_game
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @league_game
    assert_response :success
  end

  test "should update league_game" do
    patch :update, id: @league_game, league_game: {  }
    assert_redirected_to league_game_path(assigns(:league_game))
  end

  test "should destroy league_game" do
    assert_difference('LeagueGame.count', -1) do
      delete :destroy, id: @league_game
    end

    assert_redirected_to league_games_path
  end
end
