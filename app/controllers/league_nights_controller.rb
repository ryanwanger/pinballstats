class LeagueNightsController < ApplicationController
  before_action :set_league_night, only: [:show, :edit, :update, :destroy]

  # GET /league_nights
  # GET /league_nights.json
  def index
    @league_nights = LeagueNight.all
  end

  # GET /league_nights/1
  # GET /league_nights/1.json
  def show
    @player_scores = []
    puts "THEASDALSDASD"
    puts @league_night.inspect
    @league_night.league_games.each do |league_game|
      @player_scores << Score.where(league_game: league_game).order("score desc")
    end
  end

  # GET /league_nights/new
  def new
    @league_night = LeagueNight.new
  end

  # GET /league_nights/1/edit
  def edit
  end

  # POST /league_nights
  # POST /league_nights.json
  def create
    @league_night = LeagueNight.new(league_night_params)

    respond_to do |format|
      if @league_night.save
        format.html { redirect_to @league_night, notice: 'League night was successfully created.' }
        format.json { render action: 'show', status: :created, location: @league_night }
      else
        format.html { render action: 'new' }
        format.json { render json: @league_night.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /league_nights/1
  # PATCH/PUT /league_nights/1.json
  def update
    respond_to do |format|
      if @league_night.update(league_night_params)
        format.html { redirect_to @league_night, notice: 'League night was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @league_night.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /league_nights/1
  # DELETE /league_nights/1.json
  def destroy
    @league_night.destroy
    respond_to do |format|
      format.html { redirect_to league_nights_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_league_night
      @league_night = LeagueNight.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def league_night_params
      params.require(:league_night).permit(:date, :league_id, :location_id)
    end
end
