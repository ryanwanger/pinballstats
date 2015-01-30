class LeagueGamesController < ApplicationController
  before_action :set_league_game, only: [:show, :edit, :update, :destroy]

  # GET /league_games
  # GET /league_games.json
  def index
    @league_games = LeagueGame.all
  end

  # GET /league_games/1
  # GET /league_games/1.json
  def show
  end

  # GET /league_games/new
  def new
    @league_game = LeagueGame.new
  end

  # GET /league_games/1/edit
  def edit
  end

  # POST /league_games
  # POST /league_games.json
  def create
    @league_game = LeagueGame.new(league_game_params)

    respond_to do |format|
      if @league_game.save
        format.html { redirect_to @league_game, notice: 'League game was successfully created.' }
        format.json { render action: 'show', status: :created, location: @league_game }
      else
        format.html { render action: 'new' }
        format.json { render json: @league_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /league_games/1
  # PATCH/PUT /league_games/1.json
  def update
    respond_to do |format|
      if @league_game.update(league_game_params)
        format.html { redirect_to @league_game, notice: 'League game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @league_game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /league_games/1
  # DELETE /league_games/1.json
  def destroy
    @league_game.destroy
    respond_to do |format|
      format.html { redirect_to league_games_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league_game
      @league_game = LeagueGame.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_game_params
      params.require(:league_game).permit(:game_id, :league_night_id)
    end
end
