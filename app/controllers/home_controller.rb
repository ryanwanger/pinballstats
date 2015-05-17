class HomeController < ApplicationController
  def index
  	redirect_to league_path(League.last)
  end
end
