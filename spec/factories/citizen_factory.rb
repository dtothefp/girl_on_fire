FactoryGirl.define do
  factory :citizen do
    age   {(1..60).to_a.sample}
    sex   {"#{["f", "m"].sample}"}
    name  {"Citizen" + (1..60).to_a.sample.to_s}
    district
  end

  factory :tribute, :parent => :citizen, :class => "Tribute" do
  end

  factory :sponsor, :parent => :sponsor, :class => "Sponsor" do
  end
end