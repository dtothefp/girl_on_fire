class Game < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true

  has_many :rounds
  has_many :tributes
  has_many :sponsors  
end