FactoryGirl.define do 
  factory :cut, class: "Cut" do
    factory :london do
      animal_type "Cow"
      name "London Broil"
      price 4
      package_weight 2
      percent 1.67
      comp 7.99
      savings 50
      description "'London Broil' was first a preparation technique, but became the name for the two cuts -- Flank and, increasingly, Top Round -- that the technique applied to."
    end

    factory :ground do
      animal_type "Cow"
      name "Ground Beef"
      price 2.63
      package_weight 1
      percent 7.67
      comp 6.99
      savings 62
      description "Burgers, meatballs, meatloaf and beef moussaka."
    end

    factory :stew do
      animal_type "Cow"
      name "Beef Stew"
      price 2.78
      package_weight 2.22
      percent 4.25
      comp 7.99
      savings 65 
      description "Tagine, bourgignon, pot au feu, chili, and a good old fashioned beef stew."
    end

    factory :brisket do
      animal_type "Cow"
      name "Brisket"
      price 5.35
      package_weight 4
      percent 0.67
      comp 8.99
      savings 40
      description "The classic roasting/braising/BBQ/Passover cut from just below the chuck at the front of the animal."
    end

    factory :cross do
      animal_type "Cow"
      name "Cross Rib"
      price 4.5
      package_weight 3.38
      percent 2.25
      comp 7.99
      savings 44
      incentive true
      description "Similar to the Chuck Roast, a braiser or roaster. Cook long and low."
    end
  end
end