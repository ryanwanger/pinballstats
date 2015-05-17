class TeamPlayersController < ApplicationController
  before_action :set_team_player, only: [:show, :edit, :update, :destroy]

  # GET /team_players
  # GET /team_players.json
  def index
    @team_players = TeamPlayer.all
  end

  # GET /team_players/1
  # GET /team_players/1.json
  def show
  end

  # GET /team_players/new
  def new
    @team_player = TeamPlayer.new
  end

  # GET /team_players/1/edit
  def edit
  end

  # POST /team_players
  # POST /team_players.json
  def create
    @team_player = TeamPlayer.new(team_player_params)

    respond_to do |format|
      if @team_player.save
        format.html { redirect_to @team_player, notice: 'Team player was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team_player }
      else
        format.html { render action: 'new' }
        format.json { render json: @team_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /team_players/1
  # PATCH/PUT /team_players/1.json
  def update
    respond_to do |format|
      if @team_player.update(team_player_params)
        format.html { redirect_to @team_player, notice: 'Team player was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team_player.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /team_players/1
  # DELETE /team_players/1.json
  def destroy
    @team_player.destroy
    respond_to do |format|
      format.html { redirect_to team_players_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team_player
      @team_player = TeamPlayer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_player_params
      params.require(:team_player).permit(:team_id, :player_id)
    end
end
