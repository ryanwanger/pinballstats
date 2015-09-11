class LeaguesController < ApplicationController
  before_action :set_league, only: [:show, :edit, :update, :destroy]

  # GET /leagues
  # GET /leagues.json
  def index
    @leagues = League.all
  end

  # GET /leagues/1
  # GET /leagues/1.json
  def show
    @admin = params[:admin] ? true : false

    if @league.uses_matchups?
      @players = []
      @win_loss = []
      @league.players.each do |player|
        @players << [player.nickname, sprintf('%.2f', Score.where(player_id: player).average(:outscored_percentage))]
        scores = Score.where(player_id: player).where(league_game_id: LeagueGame.where(league_night_id: @league.league_nights))
        wins = scores.select{|s| s.team_win == true}.count
        @win_loss << [player.nickname, wins, scores.count - wins]
      end
      @players.sort!{|a,b| b[1] <=> a[1]}
      @win_loss.sort!{|a,b| b[1] <=> a[1]}
    end
  end

  # GET /leagues/new
  def new
    @league = League.new
  end

  # GET /leagues/1/edit
  def edit
  end

  # POST /leagues
  # POST /leagues.json
  def create
    @league = League.new(league_params)

    respond_to do |format|
      if @league.save
        format.html { redirect_to @league, notice: 'League was successfully created.' }
        format.json { render action: 'show', status: :created, location: @league }
      else
        format.html { render action: 'new' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /leagues/1
  # PATCH/PUT /leagues/1.json
  def update
    respond_to do |format|
      if @league.update(league_params)
        format.html { redirect_to @league, notice: 'League was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @league.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leagues/1
  # DELETE /leagues/1.json
  def destroy
    @league.destroy
    respond_to do |format|
      format.html { redirect_to leagues_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league
      @league = League.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_params
      params.require(:league).permit(:start_date, :title)
    end
end
