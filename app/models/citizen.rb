class Citizen < ActiveRecord::Base
  validates :name, :age, :sex, :district_id, presence: true
  validate :same_name_and_district, :on => :create

  belongs_to :district


  # def namesafe_save
  #   matching_citizens = Citizen.all.where("name= '#{self.name}' AND district_id= '#{self.district_id}'")
  #   if matching_citizens.count > 0
  #     name = name + (matching_citizens.count + 1).to_s
  #   end
  #   self.save
  # end



  private

  def same_name_and_district
    unless self.name.nil? || self.district_id.nil?
      matching_citizens = Citizen.all.where("name= '#{self.name}' AND district_id= '#{self.district_id}'")
      # binding.pry
      if matching_citizens.count != 0
        errors.add(:name, "Citizen associated with District #{self.district_id} cannot have the same name")
      end
    end
  end
end