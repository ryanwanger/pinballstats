class LeagueNightsController < ApplicationController
  before_action :set_league_night, only: [:show, :edit, :update, :destroy, :create_groups]

  # GET /league_nights
  # GET /league_nights.json
  def index
    @league_nights = LeagueNight.all
  end

  # GET /league_nights/1
  # GET /league_nights/1.json
  def show
    @admin = params[:admin]
    @player_scores = []
    @league_night.league_games.each do |league_game|
      @player_scores << Score.where(league_game: league_game).order("score desc")
    end
  end

  # GET /league_nights/new
  def new
    @league_night = LeagueNight.new(league_id: params[:league_id] || League.last)
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

  def create_groups
    player_ids = params[:player].reject {|k,v| v == "0"}.keys

    groups_of_three = 0
    case player_ids.length % 4
    when 1
      groups_of_three = 3
    when 2
      groups_of_three = 2
    when 3
      groups_of_three = 1
    end

    groups_of_four = (player_ids.length - (groups_of_three * 3)) / 4

    groupings = []
    groups_of_four.times { groupings << player_ids.slice!(0..3)}
    groups_of_three.times { groupings << player_ids.slice!(0..2)}

    groupings.each_with_index do |grouping, group_rank|
      g = Group.create(league_night_id: @league_night.id, group_rank: group_rank + 1)
      grouping.each do |player_id|
        GroupPlayer.create(group_id: g.id, player_id: player_id.to_i)
      end
    end

    redirect_to league_night_path(@league_night)
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
