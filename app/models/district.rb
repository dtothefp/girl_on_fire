class District < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  #validate :find_tribute

  has_many :citizens

  def find_tributes
    self.citizens.where(type: "Tribute")
  end

  def can_reap?
    tributes = reap
    if tributes[0].nil? || tributes[1].nil?
      return false
    else
      return true
    end
  end

  def reap
    citizens = []
    
    citizens << self.citizens.where(sex:"m").where("age BETWEEN 12 AND 18").sample
    citizens << self.citizens.where(sex:"f").where("age BETWEEN 12 AND 18").sample
    if !citizens.include?(nil)
      citizens.each do |citizen|
        citizen.type = "Tribute"
        citizen.save
        # binding.pry
      end
    end
    citizens
  end

end