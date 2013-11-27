require 'spec_helper'

describe Round do
  let(:game) { FactoryGirl.create(:game) }
  subject(:round) { Round.new(name: "First Round", game: game) }

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:game_id) }

    it { should belong_to(:game) }
    it { should have_and_belong_to_many(:tributes) }

    describe "#same_name_and_game" do
      context "rounds associated with the same game have identical names" do
        before do
          3.times { FactoryGirl.create(:round, game: game) }
          matched_round = Round.first
          matched_round.name = "First Round"
          matched_round.save
        end
        it "is not valid" do
          expect(round).to have(1).errors_on(:name)
        end
      end
    end
  end

end