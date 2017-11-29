class Player < ApplicationRecord
  belongs_to :character
  belongs_to :replay
  belongs_to :map
end
