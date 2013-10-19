FactoryGirl.define do

  factory :user, class: User do
    
    name     "Basic User"
    email    "basic@emailclient.com"
    password "password"
    password_confirmation "password"
    zip 94114

    factory :sasha do
      name "Sasha Klein"
      email "sasha@emailclient.com"
      admin true
      beta false
    end

    factory :nonbeta do
    	name     "NonBeta User"
      email    "blocked@emailclient.com"
      admin false
      beta true
    end

    factory :beta do
    	name     "Beta User"
      email    "user@emailclient.com"
      admin false
      beta true
    end
  end
end
