FactoryGirl.define do
  factory :origin do
    campus "livingston"
    building "livingston apartments"
    floor 1
    style "Double - Apartment"
  end

  trait :busch do
    campus "busch"
    building "silvers apartments"
  end

  trait :cookdouglass do
    campus "cook/douglass"
    building "newell apartments"
  end
end
