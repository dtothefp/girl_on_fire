class Round < ActiveRecord::Base
  validates :name, :game_id, presence: true
  validate :rounds_per_game

  belongs_to :game
  has_and_belongs_to_many :tributes

  def fight
    current_game = Game.find(self.game_id)
    combat = []
    2.times do 
      combat << current_game.tributes.sample
    end
    loser = combat.sample
    current_game.tributes.delete(loser)
    loser.alive = false
    loser.save
    current_game.tributes.each do |tribute|
      self.tributes << tribute
    end
    self.tributes
    # binding.pry
  end

  private 

  def rounds_per_game
    unless self.name.nil? || self.game_id.nil?
      matching_rounds = Round.where("name= '#{self.name}' AND game_id= '#{self.game_id}'")
      if matching_rounds.count != 0
        errors.add(:name, "Rounds associated with Game #{self.game_id} cannot have the same name")
      end
      round_count = Round.where(game_id: self.game_id)
      if round_count.count >= 3
        errors.add(:game_id, "Only 3 rounds can be associated with 1 game")
      end
    end
  end
end