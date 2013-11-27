require 'spec_helper'

describe Citizen do
  let(:district) { District.create(name: "New District") }

  subject(:citizen) { Citizen.new(name: "Citizen 1", age: 20, sex: "M", district: district) }

  describe "validations" do
    it { should validate_presence_of(:age) }
    it { should validate_presence_of(:sex) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:district_id) }

    it { should belong_to(:district) }
  end

  describe "#same_name_and_district" do
    context "the citizen has the same name in the same district" do
      before do
        saved_citizen = FactoryGirl.create(:citizen, district: district)
        saved_citizen.name = "Citizen 1"
        saved_citizen.save
      end
      it "is not valid" do
        expect(citizen).to have(1).errors_on(:name)
      end
    end
  end
  
end