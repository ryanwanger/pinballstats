class Matchup < ActiveRecord::Base
  belongs_to :league_night
  has_many :teams
end
