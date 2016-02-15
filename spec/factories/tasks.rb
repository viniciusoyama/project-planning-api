FactoryGirl.define do
  factory :task do
    name "Task Name"
    client
    project
    notes "task note"
    start_at Date.current
    end_at 3.days.from_now
  end
end
