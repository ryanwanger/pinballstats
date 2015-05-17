class ScoreKeepersController < ApplicationController
  # before_action :set_player, except: [:login]

  def fetch
    puts session.inspect
    if session[:player_id]
        @player = Player.find(session[:player_id])
        redirect_to player_path(@player)
        return
    end
  end

  def login
    unless params[:name].blank?
      t = Player.arel_table
      players = Player.where(t[:name].matches("%#{params[:name].downcase}"))

      if players.any?
        player = players.first
        session[:player_id] = player.id
        redirect_to player_path(player)
        return
      else
        player = Player.create(name: params[:name])
        session[:player_id] = player.id
        redirect_to player_path(player)
        return
      end
    end

    redirect_to fetch_score_keepers_path
  end

  def show

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_player

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def group_params
    #   params.require(:group).permit(:league_night_id, :player_id, :group_rank)
    # end
end
