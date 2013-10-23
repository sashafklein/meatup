FactoryGirl.define do 
  factory :cut, class: "Cut" do

    name "Fake Cut"
    price 3
    package_weight 1
    percent 20
    description "A super fake cut"
    animal_type "cow"
    comp 4

    factory :london do
      name "London Broil"
      price 4
      comp 5
      package_weight 4
      percent 15
      description "'London Broil' was first a preparation technique, but became the name for the two cuts -- Flank and, increasingly, Top Round -- that the technique applied to."
      savings 50
      prep_options 'grind stew'
    end

    factory :ground do
      name "Ground Beef"
      price 2
      comp 3
      package_weight 1
      percent 50
      description "Burgers, meatballs, meatloaf and beef moussaka."
      savings 62
    end

    factory :stew do
      name "Beef Stew"
      price 3
      comp 4
      percent 25
      package_weight 2
      description "Tagine, bourgignon, pot au feu, chili, and a good old fashioned beef stew."
      savings 32
      prep_options 'grind'
    end

    factory :filet do
      name "Filet Mignon"
      price 20
      comp 32
      package_weight 3
      percent 10
      description "The classic roasting/braising/BBQ/Passover cut from just below the chuck at the front of the animal."
      savings 5
    end
  end
end