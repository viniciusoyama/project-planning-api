require 'rails_helper'

describe Task, type: :model do
  it "sets client to be the project client before validating" do
    project = FactoryGirl.create :project
    task = FactoryGirl.build :task, project: project, client: nil
    task.valid?
    expect(task.client).to eq(project.client)
  end

  it "has default effort of 8" do
    expect(Task.new.effort_per_day_in_hours).to eq(8)
  end
end
