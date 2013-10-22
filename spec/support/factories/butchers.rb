FactoryGirl.define do

  factory :butcher, class: "Butcher" do
    name            "Sanders Meat Co"
    address         "Turlock St."
    city            "Turlock"
    state           "CA"
    zip             "94114"
    phone           "999-999-9999"
    hanging_price   0.55
    final_price     0
    wrap_price      0
    vacuum_price    0.00
    ground          true
    stew            false
    boneless        true
  end

end