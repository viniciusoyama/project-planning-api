FactoryGirl.define do
  factory :project do
    sequence(:name)  { |n| "project #{n}" } 
    sequence(:description)  { |n| "description #{n}" } 
    client
  end
end
