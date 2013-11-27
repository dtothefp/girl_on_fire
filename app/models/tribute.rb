class Tribute < Citizen
  validates :district_id, :game_id, presence: true

  belongs_to :game
  has_and_belongs_to_many :rounds
  has_many :sponsorships
  has_many :sponsors, through: :sponsorships
end