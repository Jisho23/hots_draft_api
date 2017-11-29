class Map < ApplicationRecord
  has_many :games
  has_many :replays
  has_many :players, through: :replays
  has_many :characters, through: :players
end
