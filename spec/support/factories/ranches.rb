FactoryGirl.define do

  factory :ranch, class: "Ranch" do
    name                "Miller Ranch"
    location
    has_csa             true
    delivers_butcher    true
    delivers_drop       true
    delivers_host       false

    factory :miller do
      after :build do |miller|
        FactoryGirl.create(:ranch_animal, ranch: miller)
      end
    end
  end

end