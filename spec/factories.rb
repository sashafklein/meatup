FactoryGirl.define do
  factory :user do
    name     "Sasha Klein"
    email    "sasha@emailclient.com"
    password "password"
    password_confirmation "password"
    zip 94114
    admin false
  end
end
