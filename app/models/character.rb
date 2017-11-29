class Character < ApplicationRecord
  has_many :players
  has_many :replays, through: :players
  has_many :maps, through: :replays
end
