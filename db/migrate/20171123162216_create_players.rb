class CreatePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :players do |t|
      t.integer :character_id
      t.integer :replay_id
      t.integer :map_id
      t.boolean :winner
      t.timestamps
    end
  end
end
