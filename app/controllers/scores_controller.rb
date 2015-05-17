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
    Matchup.all.each do |matchup|
      matchup.teams.each do |team|
        team.each do |player|
          matchup.league_night.league_games.each do |league_game|
            unless Score.where(player: player, league_game: league_game).exists?
              redirect_to new_score_path(player_id: player.id, league_game_id: league_game.id)
              return
            end 
          end
        end
      end
    end

    # Group.all.each do |group|
    #   group.players.each do |player|
    #     group.league_night.league_games.each do |league_game|
    #       unless Score.where(player: player, group: group, league_game: league_game).exists?
    #         redirect_to new_score_path(player_id: player.id, league_game_id: league_game.id, group_id: group.id)
    #         return
    #       end 
    #     end
    #   end
    # end
  end

  def standings

  end

  # GET /scores/new
  def new
    @group = Group.find(params[:group_id])
    @score = Score.new(player_id: params[:player_id], league_game_id: params[:league_game_id], group_id: params[:group_id])
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
        format.html { redirect_to @score, notice: 'Score was successfully created.' }
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
