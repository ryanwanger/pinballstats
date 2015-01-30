class CreateGroupPlayers < ActiveRecord::Migration
  def change
    create_table :group_players do |t|
      t.references :group, index: true
      t.references :player, index: true

      t.timestamps
    end
  end
end
