class Replay < ApplicationRecord
  belongs_to :map
  has_many :players
  has_many :characters, through: :players
end
