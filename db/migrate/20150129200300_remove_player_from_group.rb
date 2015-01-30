class RemovePlayerFromGroup < ActiveRecord::Migration
  def change
  	remove_column :groups, :player_id
  end
end
