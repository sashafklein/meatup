FactoryGirl.define do

  factory :location do
    sequence(:street_address) { |n| "Whatever Street \##{n}" }
    city "City"
    sequence(:phone_number) { |n| "999-999-999#{n}" }
    state "CA"
    zip "94114"
  end
  
end