class AddPercentOfAverage < ActiveRecord::Migration
  def change
  	add_column :scores, :percent_of_average, :decimal, precision: 6, scale: 4
  end
end
