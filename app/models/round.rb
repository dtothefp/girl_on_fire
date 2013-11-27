class Round < ActiveRecord::Base
  validates :name, :game_id, presence: true
  validate :same_name_and_game

  belongs_to :game
  has_and_belongs_to_many :tributes

  private 

  def same_name_and_game
    unless self.name.nil? || self.game_id.nil?
      matching_rounds = Round.all.where("name= '#{self.name}' AND game_id= '#{self.game_id}'")
      if matching_rounds.count != 0
        errors.add(:name, "Rounds associated with Game #{self.game_id} cannot have the same name")
      end
    end
  end
end