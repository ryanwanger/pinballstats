class HomeController < ApplicationController
  def index
  	redirect_to leagues_path
  end
end
