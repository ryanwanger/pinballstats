class ScoresController < ApplicationController
  before_action :set_score, only: [:show, :edit, :update, :destroy]

  # GET /scores
  # GET /scores.json
  def index
    @scores = Score.all
  end

  # GET /scores/1
  # GET /scores/1.json
  def show
  end

  def next
    # When there are teammates

    # Matchup.all.each do |matchup|
    #   matchup.teams.each do |team|
    #     team.players.each do |player|
    #       matchup.league_night.league_games.each do |league_game|
    #         unless Score.where(player: player, league_game: league_game).exists?
    #           redirect_to new_score_path(player_id: player.id, league_game_id: league_game.id)
    #           return
    #         end 
    #       end
    #     end
    #   end
    # end

    # When there are no teammates

    Group.where("created_at > ?", Time.current - 7.days).each do |group|
      group.league_night.league_games.each_with_index do |league_game, gi|
        player_count = group.players.count

        (0..player_count-1).each do |player_number|
          player_index = (player_count - gi + player_number) % player_count
          player = group.group_players[player_index].player
          unless Score.where(player: player, group: group, league_game: league_game).exists?
            redirect_to new_score_path(player_id: player.id, league_game_id: league_game.id, group_id: group.id)
            return
          end 
        end
      end
    end
  end

  def calculate
    Score.where("created_at > ?", Time.now - 1.day).each{|s| s.calculate_points}
    redirect_to root_path
  end

  def standings

  end

  # GET /scores/new
  def new
    @score = Score.new(player_id: params[:player_id], league_game_id: params[:league_game_id], group_id: params[:group_id])

    # if params[:game_id] && session[:player_id]
    #   league_night = League.find(3).league_nights.first
    #   @game = Game.find(params[:game_id])
    #   league_game = LeagueGame.find_or_create_by(league_night: league_night, game_id: @game.id)
    #   @score = Score.new(player_id: session[:player_id], league_game_id: league_game.id)
    #   @hide_inputs = true
    # else
    #   @score = Score.new(player_id: params[:player_id], league_game_id: params[:league_game_id])
    # end
  end

  # GET /scores/1/edit
  def edit
  end

  # POST /scores
  # POST /scores.json
  def create
    @score = Score.new(score_params)

    respond_to do |format|
      if @score.save
        format.html { redirect_to next_scores_path, notice: 'Score was successfully created.' }
        format.json { render action: 'show', status: :created, location: @score }
      else
        format.html { render action: 'new' }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scores/1
  # PATCH/PUT /scores/1.json
  def update
    respond_to do |format|
      if @score.update(score_params)
        format.html { redirect_to @score, notice: 'Score was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @score.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scores/1
  # DELETE /scores/1.json
  def destroy
    @score.destroy
    respond_to do |format|
      format.html { redirect_to scores_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_score
      @score = Score.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def score_params
      params.require(:score).permit(:score, :player_id, :league_game_id, :group_id)
    end
end
