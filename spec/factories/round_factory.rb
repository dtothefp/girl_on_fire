FactoryGirl.define do
  factory :round do
    name { "Round" + (1..10).to_a.sample.to_s }
    game
  end
end