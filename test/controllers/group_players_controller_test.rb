require 'test_helper'

class GroupPlayersControllerTest < ActionController::TestCase
  setup do
    @group_player = group_players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:group_players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group_player" do
    assert_difference('GroupPlayer.count') do
      post :create, group_player: { group: @group_player.group, player_id: @group_player.player_id }
    end

    assert_redirected_to group_player_path(assigns(:group_player))
  end

  test "should show group_player" do
    get :show, id: @group_player
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @group_player
    assert_response :success
  end

  test "should update group_player" do
    patch :update, id: @group_player, group_player: { group: @group_player.group, player_id: @group_player.player_id }
    assert_redirected_to group_player_path(assigns(:group_player))
  end

  test "should destroy group_player" do
    assert_difference('GroupPlayer.count', -1) do
      delete :destroy, id: @group_player
    end

    assert_redirected_to group_players_path
  end
end
