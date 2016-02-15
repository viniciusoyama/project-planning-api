FactoryGirl.define do
  factory :person do
    sequence(:name)  { |n| "person #{n}" }
    sequence(:email)  { |n| "person#{n}@test.com" }
    job_title "Test Senior"
  end
end
