class AddIndexToPlayers < ActiveRecord::Migration[5.1]
  def change
      add_index :players, [:replay_id, :map_id]
  end
end
