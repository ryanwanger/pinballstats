class HomeController < ApplicationController
  def index
  	redirect_to league_path(League.find(1))
  end
end
