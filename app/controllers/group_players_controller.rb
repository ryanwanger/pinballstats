class GroupPlayersController < ApplicationController
  before_action :set_group_player, only: [:show, :edit, :update, :destroy]

  # GET /group_players
  # GET /group_players.json
  def index
    @group_players = GroupPlayer.all
  end

  # GET /group_players/1
  # GET /group_players/1.json
  def show
  end

  # GET /group_players/new
  def new
    @group_player = GroupPlayer.new(group_id: params[:group_id])
  end

  # GET /group_players/1/edit
  def edit
  end

  # POST /group_players
  # POST /group_players.json
  def create
    @group_player = GroupPlayer.new(group_player_params)

    respond_to do |format|
      if @group_player.save
        format.html { redirect_to @group_player, notice: 'Group player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group_player }
      else
        format.html { render action: 'new' }
        format.json { render json: @group_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /group_players/1
  # PATCH/PUT /group_players/1.json
  def update
    respond_to do |format|
      if @group_player.update(group_player_params)
        format.html { redirect_to @group_player, notice: 'Group player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_players/1
  # DELETE /group_players/1.json
  def destroy
    @group_player.destroy
    respond_to do |format|
      format.html { redirect_to group_players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_player
      @group_player = GroupPlayer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_player_params
      params.require(:group_player).permit(:group_id, :player_id)
    end
end
