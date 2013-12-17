FactoryGirl.define do

  factory :animal, class: "Animal" do
    breed         "Cow Breed"
    name          "Mr. Moo"
    animal_type   "cow"
    live_weight        100
    no_sales      true
    conduct_opening_sale  false
    price_multiplier  1

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

    factory :tiny do 
      live_weight  10 

      factory :butchered_tiny do
        after(:build) do |tiny|
          name = 'Tiny the Cow'
          butcher = FactoryGirl.create(:butcher)
          tiny.butcher_id = butcher.id
        end
      end
    end

    factory :small do
      live_weight 100

      factory :butchered_small do
        after(:build) do |small|
          butcher = FactoryGirl.create(:butcher)
          small.butcher_id = butcher.id
        end
      end
    end


  end
end
