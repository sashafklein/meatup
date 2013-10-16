FactoryGirl.define do

  factory :ranch, class: "Ranch" do
    name                "Miller Ranch"
    address             "Ranch Road"
    phone               "999-999-9999"
    state               "CA"
    city                "Oakdale"
    zip                 "94114"
    has_csa             true
    delivers_butcher    true
    delivers_drop       true
    delivers_host       false
    cow                 true
    cow_live            1.40
    pig                 false
    lamb                false
    goat                false
  end

end