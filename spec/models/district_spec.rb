require 'spec_helper'

describe District do
  let(:game) { FactoryGirl.create(:game) }

  subject(:district) { District.new(name: "1") }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should have_many(:citizens) }
  end

  describe "#find_tributes" do
    let(:tribute) { FactoryGirl.create(:tribute, district: district, game: game) }
    before do
      district.save
    end
    it "finds a tribute in the district" do
      expect(district.find_tributes).to include(tribute)
    end
  end

  describe "#can_reap?" do
    describe "returns true if there are citizens that fulfill the reaping requirements;" do
      context "there are not citizens that meet the requirement" do
        before do
          # TODO set it up!
          district.save
          counter = 1
          20.times do
            FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, age: (19..99).to_a.sample, district: district )
            counter += 1
          end
        end

        it "returns false" do
          expect(district.can_reap?).to eq(false)
        end
      end

      context "there are citizens that meet the requirment" do
        before do
          # TODO set it up!
          district.save
          counter = 1
          20.times do
            FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, age: (19..99).to_a.sample, district: district )
            counter += 1
          end
          @female_citizen = Citizen.first
          @female_citizen.age = 16
          @female_citizen.sex = "f"
          @female_citizen.save
          @male_citizen = Citizen.last
          @male_citizen.sex = "m"
          @male_citizen.age = 16
          @male_citizen.save
        end

        it "returns true" do
          expect(district.can_reap?).to eq(true)
        end
      end
    end
  end

  describe "#reap" do
    subject (:reaping_district) {FactoryGirl.create(:district)}

    context "2 random citizens, 1 male & 1 female are chosen" do
      before do
        district.save
        counter = 1
        5.times do
          FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, district: district )
          counter += 1
        end
        FactoryGirl.create(:citizen, name: "New Citizen ensure f", age: 16, sex: "f", district: district )
        FactoryGirl.create(:citizen, name: "New Citizen ensure m", age: 16, sex: "m", district: district )
      end
      it "2 citizens are chosen" do
        #binding.pry
        expect(district.reap.count).to eq(2)
      end
      it "has one male" do
        expect(district.reap.select { |citizen| citizen.sex == "m"}.count ).to eq(1)
      end
      it "has one female" do
        expect(district.reap.select { |citizen| citizen.sex == "f"}.count ).to eq(1)
      end

    end

    context "among a group, only picks ages between 12 and 18" do
      before do
        district.save
        counter = 1
        20.times do
          FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, sex: "m", age: (19..99).to_a.sample, district: district )
          counter += 1
        end
        @our_guy = FactoryGirl.create(:citizen, name: "New Citizen Male",sex: "m", age: 18, district: district )
        20.times do
          FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, sex: "f", age: (19..99).to_a.sample, district: district )
          counter += 1
        end
        @our_girl = FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, sex: "f", age: 16, district: district )
      end

      it "contains *that* female" do
        expect(district.reap.select { |citizen| citizen.sex == "f"}[0]).to eq(@our_girl)
      end

      it "contains *that* male" do
        expect(district.reap.select { |citizen| citizen.sex == "m"}[0]).to eq(@our_guy)
      end
    end
    context "citizens chosen by the reap method are instantiated as Tributes" do
      before do
        district.save
        counter = 1
        20.times do
          FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, sex: "m", age: (12..20).to_a.sample, district: district )
          counter += 1
        end
        Citizen.first.age = 30
        20.times do
          FactoryGirl.create(:citizen, name: "New Citizen" + counter.to_s, sex: "f", age: (12..20).to_a.sample, district: district )
          counter += 1
        end
        Citizen.last.age = 30
      end
      it "each chosen citizen is a tribute" do
        expect(district.reap[0].type).to eq("Tribute")
        expect(district.reap[1].type).to eq("Tribute")
      end
    end
  end

 

end