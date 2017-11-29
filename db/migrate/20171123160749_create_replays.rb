class CreateReplays < ActiveRecord::Migration[5.1]
  def change
    create_table :replays do |t|
      t.integer :map_id
      t.timestamps
    end
  end
end
