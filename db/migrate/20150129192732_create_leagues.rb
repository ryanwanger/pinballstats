class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.date :start_date
      t.string :title

      t.timestamps
    end
  end
end
