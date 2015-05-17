class AddOutscoredPercentage < ActiveRecord::Migration
  def change
  	add_column :scores, :outscored_percentage, :integer
  end
end
