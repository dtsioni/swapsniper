FactoryGirl.define do
  factory :user do
    sequence(:first_name) { |n| "ex_first_#{n}" }
    sequence(:last_name) { |n| "ex_last_#{n}" }
    sequence(:email) { |n| "test#{n}@rutgers.edu" }
    password "password"
    gender "male"
    role "student"
  end

  trait :male do
    gender "male"
  end

  trait :female do
    gender "female"
  end
end
