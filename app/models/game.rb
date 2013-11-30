class Game < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :rounds
  has_many :tributes
  has_many :sponsors  

  def get_tributes
    tributes = Tribute.where(game_id: self.id)
  end

end