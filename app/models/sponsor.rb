class Sponsor < Citizen
  validates :district_id, :game_id, presence: true

  belongs_to :game
  has_many :sponsorships
  has_many :tributes, through: :sponsorships
end