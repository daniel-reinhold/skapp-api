class Game < ApplicationRecord
  belongs_to :sheet
  has_many :participant_results
end
