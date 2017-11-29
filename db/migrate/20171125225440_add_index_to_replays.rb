class AddIndexToReplays < ActiveRecord::Migration[5.1]
  def change
    add_index :replays, :map_id
  end
end
