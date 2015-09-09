FactoryGirl.define do
  factory :origin do
    floor 1
    style "Double - Apartment"
  end

  trait :livingston do
    campus "livingston"
    building "livingston apartments"
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
