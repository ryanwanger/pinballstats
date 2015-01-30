class ScoreToBignum < ActiveRecord::Migration
  def change
  	change_column :scores, :score, :integer, limit: 8
  end
end
