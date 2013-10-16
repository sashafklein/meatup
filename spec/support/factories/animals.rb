FactoryGirl.define do

  factory :animal, class: "Animal" do
    breed         "Cow Breed"
    name          "Cowy Name"
    animal_type   "Cow"
    weight        1216
    no_sales      true
    opening_sale  false

    trait :with_host do
      # host host
    end

    trait :with_ranch do
      # ranch ranch
    end

    trait :with_butcher do
      # butcher butcher
    end

    factory :paul_ryan, traits: [:with_host, :with_ranch, :with_butcher] do
      name "Paul Ryan"
      breed "Black Angus"
    end

  end
end
