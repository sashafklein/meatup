FactoryGirl.define do

  factory :user, class: "User" do
    factory :sasha do
      name     "Sasha Klein"
      email    "sasha@emailclient.com"
      password "password"
      password_confirmation "password"
      zip 94114
      admin true
      beta false
    end

    factory :nonbeta do
    	name     "Blocked User"
      email    "blocked@emailclient.com"
      password "password"
      password_confirmation "password"
      zip 94114
      admin false
      beta true
    end

    factory :beta do
    	name     "Beta User"
      email    "user@emailclient.com"
      password "password"
      password_confirmation "password"
      zip 94114
      admin false
      beta true
    end
  end
end
